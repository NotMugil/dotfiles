import { App } from "astal/gtk3";
import style from "./style.scss";
import { Bar } from "./windows/Bar";
import Applauncher from "./widgets/AppLauncher";
import QuickSettings from "./windows/QuickSettings";
import NotificationPopups from "./widgets/NotificationPopups";
import OSD from "./widgets/OSD";

App.start({
  instanceName: "astal-bar",
  css: style,
  main() {
    App.get_monitors().map(Bar);
    App.get_monitors().map(OSD);
    App.get_monitors().map(NotificationPopups);
    QuickSettings();
  },
});
