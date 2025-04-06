import { App, Astal, Gdk } from "astal/gtk3";
import { bind } from "astal";
import Battery from "gi://AstalBattery";

export default function BatteryLevel() {
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
