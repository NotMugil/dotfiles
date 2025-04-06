import { App, Astal, Gdk } from "astal/gtk3";
import { bind } from "astal";
import Wp from "gi://AstalWp";

export default function SysSettings() {
  const speaker = Wp.get_default()?.audio.defaultSpeaker!;

  return (
    <button>
      <box className="AudioSlider">
        <icon icon={bind(speaker, "volumeIcon")} />
        {/* <slider
        hexpand
        onDragged={({ value }) => (speaker.volume = value)}
        value={bind(speaker, "volume")}
      /> */}
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
