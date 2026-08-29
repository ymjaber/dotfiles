// widget/Privacy.tsx — dots visible only while active (AstalWp.Audio exposes `recorders` — apps capturing the mic — so the mic dot can be a binding, not a probe)
import { createBinding } from "ags"
import Wp from "gi://AstalWp"
import { privacy } from "../service/privacy"
// ⚠ GList-typed Astal properties are generated as `T[] | null` (`get recorders(): Stream[] | null`) — hence the `?.`
// ⚠ our own Cava widget captures the speaker monitor and appears in `recorders` as node.name "cava" —
// without the filter the bar lights its own mic dot (2026-08-28).
const mic = createBinding(Wp.get_default()!.audio, "recorders")(r => !!r?.filter(s => s.name !== "cava").length)
export default function Privacy() {
  return <box class="privacy" spacing={6}>
    <label visible={mic}                    label={"\u{f130}"} />
    <label visible={privacy(p => p.cam)}    label={"\u{f030}"} />
    <label visible={privacy(p => p.screen)} label={"\u{f108}"} />
  </box>
}
