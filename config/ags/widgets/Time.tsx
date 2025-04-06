import { GLib, Variable } from "astal";

export default function Time({ format = "%A%e, %H:%M" }) {
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
