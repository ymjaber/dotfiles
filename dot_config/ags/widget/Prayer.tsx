// widget/Prayer.tsx — bar pill: next prayer; popover: five times + Hijri + qibla
import { prayer, qibla } from "../service/prayers"
import { Gtk } from "ags/gtk4"
const ROWS: [string, string][] = [["الفجر", "Fajr"], ["الظهر", "Dhuhr"], ["العصر", "Asr"], ["المغرب", "Maghrib"], ["العشاء", "Isha"]]
const next = (t: Record<string, string>) => {
  const now = new Date().toTimeString().slice(0, 5)
  return ROWS.find(([, k]) => t[k] > now) ?? ROWS[0]
}
export default function Prayer() {
  return (
    <menubutton class="prayer" visible={prayer(p => !!p)}>
      <label label={prayer(p => { if (!p) return ""; const [a, k] = next(p.timings); return `﷽ ${a} ${p.timings[k]}` })} />
      <popover>
        <box orientation={Gtk.Orientation.VERTICAL} class="prayer-popup" spacing={4}>
          {/* ⚠ a STATIC array of elements, each bound to the accessor — never the accessor as a child (widgets.md law) */}
          {ROWS.map(([a, k]) => <label xalign={0} label={prayer(p => p ? `${a}  ${p.timings[k]}` : "")} />)}
          <label class="hijri" label={prayer(p => p ? `${p.hijri.day} ${p.hijri.month.ar} ${p.hijri.year}` : "")} />
          <label class="qibla" label={qibla(q => q ? `القبلة ${q}°` : "")} />
        </box>
      </popover>
    </menubutton>
  )
}
