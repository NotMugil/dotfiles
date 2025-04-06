// Source: https://github.com/maxverbeek/astalconfig/blob/master/service/niri.ts

import GObject, { property, register } from "astal/gobject";
import GLib from "gi://GLib?version=2.0";
import Gio from "gi://Gio?version=2.0";

export type Workspace = {
  id: number;
  idx: number;
  name: string | null;
  output: string;
  is_active: boolean;
  is_focused: boolean;
  active_window_id: number | null;
};

export type Window = {
  id: number;
  title: string | null;
  app_id: string;
  workspace_id: number;
  is_focused: boolean;
};

export type Monitor = {
  name: string;
  make: string;
  model: string;
  serial: string;
};

export type State = {
  workspaces: Map<number, Workspace>;
  windows: Map<number, Window>;
  monitors: Map<string, Monitor>;
};

export type OutputsWithWorkspacesWithWindows = Record<
  string,
  OutputWithWorkspacesWithWindows
>;

export type OutputWithWorkspacesWithWindows = {
  output: string;
  monitor: Monitor | null;
  workspaces: Record<number, WorkspaceWithWindows>;
};

export type WorkspaceWithWindows = Workspace & {
  windows: Window[];
};

type ResponseOutputs = {
  Ok: {
    Outputs: Record<string, Monitor>;
  };
};

@register({ GTypeName: "Niri" })
export default class Niri extends GObject.Object {
  static instance: Niri;
  static get_default() {
    if (!this.instance) {
      this.instance = new Niri();
    }

    return this.instance;
  }

  @property(Object)
  get outputs(): OutputsWithWorkspacesWithWindows {
    const wsmap: OutputsWithWorkspacesWithWindows = {};

    for (const win of this.#state.windows.values()) {
      const ws = this.#state.workspaces.get(win.workspace_id);

      if (!ws) {
        continue;
      }

      const output = ws.output;
      const monitor = this.#state.monitors.get(output) ?? null;

      if (!(output in wsmap)) {
        wsmap[output] = { output: output, workspaces: {}, monitor };
      }

      if (!(win.workspace_id in wsmap[output].workspaces)) {
        wsmap[output].workspaces[win.workspace_id] = { ...ws, windows: [] };
      }

      wsmap[output].workspaces[win.workspace_id].windows.push(win);
    }

    return wsmap;
  }

  #state: State;

  constructor() {
    super();

    this.#state = {
      workspaces: new Map(),
      windows: new Map(),
      monitors: new Map(),
    };

    this.reloadMonitors();
    this.listenEventStream();
  }

  public focusWorkspaceId(id: number) {
    const msg = { Action: { FocusWorkspace: { reference: { Id: id } } } };
    const result = JSON.parse(this.oneOffCommand(JSON.stringify(msg)));

    if (!("Ok" in result)) {
      console.warn(`[NIRI] switching to workspace ID ${id} failed`, result);
    }
  }

  public reloadMonitors() {
    this.#state.monitors = this.getMonitors();

    console.log(
      "[NIRI] reloaded monitors",
      Object.fromEntries(this.#state.monitors),
    );

    this.notify("outputs");
  }

  private newConnection(): Gio.SocketConnection {
    const path = GLib.getenv("NIRI_SOCKET")!;
    const client = new Gio.SocketClient().connect(
      new Gio.UnixSocketAddress({ path }),
      null,
    );

    return client;
  }

  private oneOffCommand(jsonEncodedCommand: string): string {
    const client = this.newConnection();

    client.get_output_stream().write(jsonEncodedCommand + "\n", null);

    const inputstream = new Gio.DataInputStream({
      closeBaseStream: true,
      baseStream: client.get_input_stream(),
    });

    const [response, _count] = inputstream.read_line_utf8(null);

    inputstream.close(null);

    if (!response) {
      console.warn(
        `[NIRI] received empty response when calling command ${jsonEncodedCommand}`,
      );
      return "";
    }

    return response;
  }

  private getMonitors(): Map<string, Monitor> {
    const resp = this.oneOffCommand(JSON.stringify("Outputs"));

    if (resp === "") {
      return new Map();
    }

    const parsed = JSON.parse(resp) as ResponseOutputs;
    const outputs = parsed.Ok.Outputs;

    return new Map(
      Object.values(outputs).map(({ name, make, model, serial }) => [
        name,
        { name, make, model, serial },
      ]),
    );
  }

  private listenEventStream() {
    const client = this.newConnection();

    client
      .get_output_stream()
      .write(JSON.stringify("EventStream") + "\n", null);

    const inputstream = new Gio.DataInputStream({
      closeBaseStream: true,
      baseStream: client.get_input_stream(),
    });

    this.readLineSocket(inputstream, (stream, result) => {
      if (!stream) {
        console.error("[NIRI] not stream");
        return;
      }

      const line = stream.read_line_finish(result)[0] ?? new Uint8Array([]);
      const text = new TextDecoder().decode(line);

      const message = JSON.parse(text);

      this.reconcileState(message);
    });
  }

  private readLineSocket(
    inputstream: Gio.DataInputStream,
    callback: (
      stream: Gio.DataInputStream | null,
      result: Gio.AsyncResult,
    ) => void,
  ) {
    inputstream.read_line_async(
      0,
      null,
      (stream: Gio.DataInputStream | null, result: Gio.AsyncResult) => {
        callback(stream, result);

        if (!stream) {
          return;
        }

        this.readLineSocket(stream, callback);
      },
    );
  }

  private reconcileState(message: any) {
    if ("WorkspacesChanged" in message) {
      // what is typesafety?
      this.reconcileWorkspacesChanged(message.WorkspacesChanged.workspaces);
    }

    if ("WorkspaceActivated" in message) {
      this.reconcileWorkspaceActivated(message.WorkspaceActivated);
    }

    if ("WorkspaceActiveWindowChanged" in message) {
      this.reconcileWorkspaceActiveWindowChanged(
        message.WorkspaceActiveWindowChanged,
      );
    }

    if ("WindowsChanged" in message) {
      this.reconcileWindowsChanged(message.WindowsChanged.windows);
    }

    if ("WindowOpenedOrChanged" in message) {
      this.reconcileWindowOpenedOrChanged(message.WindowOpenedOrChanged.window);
    }

    if ("WindowClosed" in message) {
      this.reconcileWindowClosed(message.WindowClosed);
    }

    if ("WindowFocusChanged" in message) {
      this.reconcileWindowFocusChanged(message.WindowFocusChanged);
    }

    this.notify("outputs");
  }

  private reconcileWorkspacesChanged(workspaces: Workspace[]) {
    this.#state.workspaces = new Map(
      workspaces.map((ws) => [
        ws.id,
        {
          id: ws.id,
          idx: ws.idx,
          name: ws.name,
          output: ws.output,
          active_window_id: ws.active_window_id,
          is_focused: ws.is_focused,
          is_active: ws.is_active,
        },
      ]),
    );
  }

  private reconcileWorkspaceActivated(workspaceActivated: any) {
    const id: number = workspaceActivated.id;
    const focused: boolean = workspaceActivated.focused;

    const workspace = this.#state.workspaces.get(id);

    if (!workspace) {
      console.warn(`Workspace ID ${id} not found in state`);
      return;
    }

    const output = workspace.output;

    this.#state.workspaces = new Map(
      Array.from(this.#state.workspaces, ([key, ws]) => {
        if (ws.output == output) {
          return [key, { ...ws, is_active: focused && id === ws.id }];
        }

        return [key, ws];
      }),
    );
  }

  private reconcileWorkspaceActiveWindowChanged(workspaceActiveWindowChanged: {
    workspace_id: number;
    active_window_id: number;
  }) {
    const id = workspaceActiveWindowChanged.workspace_id;
    const active_window_id = workspaceActiveWindowChanged.active_window_id;

    const workspace = this.#state.workspaces.get(id);

    if (!workspace) {
      console.warn(`Workspace ID ${id} not found in state`);
      return;
    }

    workspace.active_window_id = active_window_id;
  }

  private reconcileWindowsChanged(windows: Window[]) {
    this.#state.windows = new Map(
      windows.map((w) => [
        w.id,
        {
          id: w.id,
          title: w.title,
          app_id: w.app_id,
          workspace_id: w.workspace_id,
          is_focused: w.is_focused,
        },
      ]),
    );
  }

  private reconcileWindowOpenedOrChanged(window: Window) {
    this.#state.windows.set(window.id, window);

    if (window.is_focused) {
      this.#state.windows.forEach((window, key) => {
        if (key != window.id) {
          window.is_focused = false;
        }
      });
    }
  }

  private reconcileWindowClosed(windowClosed: { id: number }) {
    this.#state.windows.delete(windowClosed.id);
  }

  private reconcileWindowFocusChanged(windowFocusChanged: { id: number }) {
    const window = this.#state.windows.get(windowFocusChanged.id);

    if (!window) {
      console.warn(
        `Cannot find window with ID ${windowFocusChanged.id} in the state`,
      );
      return;
    }

    this.#state.windows.forEach((win, key) => {
      win.is_focused = key === windowFocusChanged.id;
    });
  }
}
