import { App, Astal, Gtk, Gdk } from "astal/gtk3";
import { Variable, GLib, bind } from "astal";
import Time from "../widgets/Time";
import BatteryLevel from "../widgets/BatteryLevel";
import Wifi from "../widgets/Network";
import Workspaces from "../widgets/Workspaces";
import Systray from "../widgets/Systray";

const time = Variable("").poll(1000, "date");

export function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      className="Bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={App}
    >
      <centerbox>
        <box className="left" hexpand halign={Gtk.Align.START}>
          <box className="WorkspacesBox">
            <Workspaces forMonitor={gdkmonitor} showInactiveIcons></Workspaces>
          </box>
        </box>
        <box className="center"></box>
        <box className="right" hexpand halign={Gtk.Align.END}>
          <Systray />
          <Wifi />
          <BatteryLevel />
          <Time />
        </box>
      </centerbox>
    </window>
  );
}
