// widget/SysMon.tsx — renders sysmon --json
import { createPoll } from "ags/time"
import { execAsync } from "ags/process"
import { Gtk } from "ags/gtk4"
export default function SysMon() {
  // ⚠ a failed read keeps the last reading (`prev`) — resolving to `{}` would render "NaN%"
  const s = createPoll<any>({ cpu:0, mem:0, temp:0, down:0, up:0 }, 2000,
    async (prev) => { try { return JSON.parse(await execAsync(["sysmon", "--json"])) } catch { return prev } })
  const pct = (v: number) => `${Math.round(v * 100)}%`
  const rate = (b: number) => b > 1e6 ? `${(b / 1e6).toFixed(1)}M` : `${Math.round(b / 1e3)}K`
  return <box orientation={Gtk.Orientation.VERTICAL} class="sysmon" spacing={4}>
    <box spacing={8}><label label={"\u{f2db}"} /><label label={s(x => pct(x.cpu))} /><label label={s(x => `${x.temp}°`)} /></box>
    <box spacing={8}><label label={"\u{f035b}"} /><label label={s(x => pct(x.mem))} /></box>
    <box spacing={8}><label label="↓" /><label label={s(x => rate(x.down))} /><label label="↑" /><label label={s(x => rate(x.up))} /></box>
  </box>
}
