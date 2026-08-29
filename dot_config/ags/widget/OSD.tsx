// widget/OSD.tsx  — register in app.ts; no bind (reacts to hardware keys)
import { createBinding, createState, onCleanup } from "ags"
import { createPoll, timeout, Timer } from "ags/time"
import { Astal } from "ags/gtk4"
import app from "ags/gtk4/app"
import Wp from "gi://AstalWp"
const { BOTTOM } = Astal.WindowAnchor

export default function OSD() {
  const speaker = Wp.get_default()!.audio.default_speaker
  const vol = createBinding(speaker, "volume")
  // ⚠ string form with a non-string init needs the 4th transform arg — without it the accessor yields raw stdout (a string)
  const bright = createPoll(0, 1000, "brightnessctl -m -c backlight get", out => Number(out))   // raw counts every 1000 ms; use the fn form to make it max-relative
  const [visible, setVisible] = createState(false)
  let t: Timer | undefined
  const show = () => { setVisible(true); t?.cancel(); t = timeout(1500, () => setVisible(false)) }
  // ⚠ createPoll starts on first subscribe and notifies when 0 → real value: swallow that one or the OSD pops at launch
  let primed = false
  onCleanup(vol.subscribe(show))
  onCleanup(bright.subscribe(() => { if (primed) show(); primed = true }))

  return (
    <window name="osd" namespace="osd" application={app} visible={visible} anchor={BOTTOM} layer={Astal.Layer.OVERLAY} class="osd">
      <box spacing={8}>
        <image iconName={vol(v => v === 0 ? "audio-volume-muted-symbolic" : "audio-volume-high-symbolic")} />
        {/* ⚠ change-value hands (self, scrollType, value) — read the 3rd arg; `({ value })` is self.value, the pre-change value.
            Return false so GTK's default handler still moves the knob. */}
        <slider hexpand value={vol} onChangeValue={(_s, _t, v) => { speaker.set_volume(v); return false }} />
      </box>
    </window>
  )
}
