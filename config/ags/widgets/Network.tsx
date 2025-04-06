import { App, Astal, Gdk } from "astal/gtk3";
import { bind } from "astal";
import Network from "gi://AstalNetwork";

export default function Wifi() {
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
