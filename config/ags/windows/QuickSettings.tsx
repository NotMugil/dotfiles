import { App, Astal, Gtk, Gdk } from "astal/gtk3";
import { bind } from "astal";
import Wp from "gi://AstalWp";

export default function QuickSettings() {
  const speaker = Wp.get_default()?.audio.defaultSpeaker!;

  return (
    <window
      name="quicksettings"
      className="QuickSettings"
      setup={(self) => App.add_window(self)}
      keymode={Astal.Keymode.ON_DEMAND}
      visible={false}
      onFocusOutEvent={(self) => App.toggle_window(self.name)}
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT}
    >
      <box
        className="quicksettings-box"
        clickThrough={false}
        vertical
        css="min-width: 300px;"
        valign={Gtk.Align.START}
        halign={Gtk.Align.END}
      >
        <label
          className="volume-label"
          label="Volume"
          halign={Gtk.Align.START}
        />
        <box>
          <button
            onClick={(_self, click) => {
              if (click.button === Astal.MouseButton.PRIMARY) {
                speaker.set_mute(!speaker.get_mute());
              } else if (click.button === Astal.MouseButton.SECONDARY) {
                App.toggle_window("quicksettings");
              }
            }}
          >
            <box className="volume-icon">
              <icon icon={bind(speaker, "volumeIcon")} />
            </box>
          </button>
          <slider
            hexpand
            onDragged={({ value }) => (speaker.volume = value)}
            value={bind(speaker, "volume")}
          />
        </box>
      </box>
    </window>
  );
}
