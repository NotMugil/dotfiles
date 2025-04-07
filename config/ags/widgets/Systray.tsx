import { App, Astal, Gdk } from "astal/gtk3";
import { bind } from "astal";
import Wp from "gi://AstalWp";

export default function Systray() {
  const speaker = Wp.get_default()?.audio.defaultSpeaker!;

  return (
    <button
      onClick={(_self, click) => {
        if (click.button === Astal.MouseButton.PRIMARY) {
          App.toggle_window("quicksettings");
        } else if (click.button === Astal.MouseButton.SECONDARY) {
          speaker.set_mute(!speaker.get_mute());
        }
      }}
    >
      <box className="AudioIcon">
        <icon icon={bind(speaker, "volumeIcon")} />
      </box>
      <box className="AudioSlider" css="min-width: 140px">
        <icon icon={bind(speaker, "volumeIcon")} />
        {/* <slider
        hexpand
        onDragged={({ value }) => (speaker.volume = value)}
        value={bind(speaker, "volume")}
      /> */}
      </box>
    </button>
  );
}
