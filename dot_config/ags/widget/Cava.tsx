// widget/Cava.tsx — N bars; AstalCava (roster: libastal-cava-git → libcava) pushes the values — no config file, no stdout parsing, no `cava` binary
import { createBinding } from "ags"
import AstalCava from "gi://AstalCava"
const BARS = 12
export default function Cava() {
  const cava = AstalCava.get_default()!
  cava.set_bars(BARS)
  // ⚠ measured 2026-08-28 (r930): with the default stereo=false `values` holds bars×2 (a full set per channel);
  // stereo=true gives exactly BARS entries — left half, right half — as the property doc describes.
  cava.set_stereo(true)
  const values = createBinding(cava, "values")   // number[] at ~framerate (60/s); doc: "generally 0..1, can overshoot" → clamp
  return <box class="cava" valign={2} spacing={2}>
    {Array.from({ length: BARS }, (_, i) =>
      <box class="bar" widthRequest={4} heightRequest={values(v => Math.round(Math.max(2, Math.min(1, v[i] ?? 0) * 30)))} />)}
  </box>
}
