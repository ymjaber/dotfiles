import app from "ags/gtk4/app"                   // ⚠ every <window> carries application={app}: unregistered windows are invisible to app.get_window/toggle_window (`ags toggle bar`)
import { createBinding } from "ags"
import { createPoll } from "ags/time"            // verified: createPoll(init, ms, cmd | fn) → Accessor
import AstalHyprland from "gi://AstalHyprland"
import AstalBattery from "gi://AstalBattery"
// ⚠ Every file that anchors a <window> needs these two lines (shown once here; imports stay first,
// the destructure follows them). Without them TOP/LEFT/RIGHT/BOTTOM are undefined — the 2026-08-09
// draft had no such import anywhere.
import { Astal } from "ags/gtk4"
const { TOP, LEFT, RIGHT, BOTTOM } = Astal.WindowAnchor

export default function Bar() {
  const hypr = AstalHyprland.get_default()
  const bat = AstalBattery.get_default()
  const time = createPoll("", 1000, "date '+%a %d · %H:%M'")
  const ws = createBinding(hypr, "focusedWorkspace")
  const pct = createBinding(bat, "percentage")
  return (
    <window visible name="bar" class="bar" application={app} anchor={TOP | LEFT | RIGHT} exclusivity={Astal.Exclusivity.EXCLUSIVE}>
      {/* ⚠ `visible`: GTK4 windows construct hidden — Gtk.Window/Astal.Window start with visible=false while every other widget defaults to true (measured on GTK 4.22, 2026-08-28). Enum form per the shipped template. */}
      <centerbox>
        <label $type="start" label={ws(w => `ws ${w?.id ?? "?"}`)} />
        <label $type="center" label={time} />
        {/* nf-fa-battery_full; template literals DO process escapes */}
        <label $type="end" label={pct(p => `\u{f240} ${Math.round(p * 100)}%`)} />
      </centerbox>
    </window>
  )
}
