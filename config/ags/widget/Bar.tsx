import { App, Astal, Gtk, Gdk } from "astal/gtk3";
import { Variable, GLib, bind } from "astal";
import Battery from "gi://AstalBattery";
import Network from "gi://AstalNetwork";
import Workspaces from "../widget/Workspaces";
import Dock from "../widget/Dock";

const time = Variable("").poll(1000, "date");

function Wifi() {
  const network = Network.get_default();
  const wifi = bind(network, "wifi");

  return (
    <button className="net-icon">
      <box visible={wifi.as(Boolean)}>
        {wifi.as(
          (wifi) =>
            wifi && (
              <icon
                tooltipText={bind(wifi, "ssid").as(String)}
                className="Wifi"
                icon={bind(wifi, "iconName")}
              />
            ),
        )}
      </box>
    </button>
  );
}

function BatteryLevel() {
  const bat = Battery.get_default();

  return (
    <button>
      <box className="Battery" visible={bind(bat, "isPresent")}>
        <icon className="bat-icon" icon={bind(bat, "batteryIconName")} />
        <label
          label={bind(bat, "percentage").as((p) => `${Math.floor(p * 100)} %`)}
        />
      </box>
    </button>
  );
}

function Time({ format = "%A%e, %H:%M" }) {
  const time = Variable<string>("").poll(
    1000,
    () => GLib.DateTime.new_now_local().format(format)!,
  );

  return (
    <button>
      <label className="Time" onDestroy={() => time.drop()} label={time()} />
    </button>
  );
}

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
          <Wifi />
          <BatteryLevel />
          <Time />
        </box>
      </centerbox>
    </window>
  );
}

export function DockWindow(gdkmonitor: Gdk.Monitor) {
  const { BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      className="DockWindow"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={BOTTOM}
      application={App}
    >
      <centerbox>
        <Dock forMonitor={gdkmonitor} showInactiveIcons={true} />
      </centerbox>
    </window>
  );
}
