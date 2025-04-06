import { App } from "astal/gtk3";
import style from "./style.scss";
import { Bar } from "./windows/Bar";

App.start({
  css: style,
  main() {
    App.get_monitors().map(Bar);
  },
});
