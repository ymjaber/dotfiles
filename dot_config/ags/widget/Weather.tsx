// widget/Weather.tsx
import { With } from "ags"
import { Gtk } from "ags/gtk4"
import { weather, WMO } from "../service/weather"
export default function Weather() {
  // ⚠ an Accessor is never a JSX child (Gnim would stringify it into a static "Accessor {}" label) —
  // <With> re-renders its block whenever the value changes.
  return <box class="weather" orientation={Gtk.Orientation.VERTICAL} visible={weather(w => !!w)}>
    <With value={weather}>{w => w && <box orientation={Gtk.Orientation.VERTICAL}>
      <box spacing={8}><label class="big" label={w.icon} /><label class="big" label={`${w.t}°`} /></box>
      <box spacing={6}>{w.daily.time?.slice(0, 5).map((_: any, i: number) =>
        <box orientation={Gtk.Orientation.VERTICAL}><label label={WMO[w.daily.weather_code[i]] ?? "?"} />
          <label label={`${Math.round(w.daily.temperature_2m_max[i])}°`} /></box>)}</box>
    </box>}</With>
  </box>
}
