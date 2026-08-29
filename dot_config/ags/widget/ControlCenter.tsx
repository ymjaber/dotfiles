// ⚠ ICONS ARE ESCAPES, never pasted glyphs: every Nerd Font private-use character in this file was
// silently lost once (all twelve icon labels were literally "" by 2026-08-28; the review's checkers
// caught it). JSX attribute strings do NOT process escapes, hence label={"\u{f028}"} not label="\u{f028}".
// Codepoints are Nerd Font nf-fa-*/nf-md-* and were checked against the installed JetBrainsMono NF.
// widget/ControlCenter.tsx  — SUPER+SHIFT+C toggles it (bind in desktop.md manifest)
import { createBinding, createState } from "ags"
import { execAsync } from "ags/process"
import { Astal } from "ags/gtk4"
import app from "ags/gtk4/app"
import Wp from "gi://AstalWp"
import Bluetooth from "gi://AstalBluetooth"
import Network from "gi://AstalNetwork"
import PowerProfiles from "gi://AstalPowerProfiles"
import Toggle from "./Toggle"
const { TOP, RIGHT } = Astal.WindowAnchor

export default function ControlCenter() {
  const speaker = Wp.get_default()!.audio.default_speaker
  const vol = createBinding(speaker, "volume")
  const bt = Bluetooth.get_default()
  const btPower = createBinding(bt, "isPowered")
  const net = Network.get_default()
  const pp = PowerProfiles.get_default()
  const [dnd, setDnd] = createState(false)
  const [pol, setPol] = createState("auto")             // sun policy: auto|light|dark (theming.md)
  execAsync(["sun", "policy"]).then(p => setPol(p.trim())).catch(() => {})

  return (
    // ⚠ application={app}: `ags toggle control-center` finds the window by name in app.windows and
    // throws "no window registered" otherwise. No `visible` — a toggled panel starts hidden.
    <window name="control-center" namespace="control-center" application={app} anchor={TOP | RIGHT}
      layer={Astal.Layer.OVERLAY} keymode={Astal.Keymode.ON_DEMAND} class="cc">
      <box orientation={1} spacing={12}>
        {/* audio — change-value's 3rd arg is the NEW value; self.value still holds the old one until
            GTK's default handler (run last) applies it. Clamp: set_volume accepts up to 1.5. */}
        <box spacing={8}>
          <label label={"\u{f028}"} />
          <slider hexpand value={vol}
            onChangeValue={(_self, _scroll, v) => speaker.set_volume(Math.min(1, Math.max(0, v)))} />
          <label label={vol(v => `${Math.round(v * 100)}%`)} />
        </box>
        {/* toggles row */}
        <box spacing={8} homogeneous>
          <button class={btPower(p => p ? "on" : "")} onClicked={() => bt.toggle()}>
            <label label={"\u{f293}"} />
          </button>
          {/* nmtui is a TUI: spawned bare it dies with "Failed to open terminal." — open it in kitty;
              the scratch-* class hits desktop.md's float rule, so it pops up centred */}
          <button onClicked={() => execAsync(["kitty", "--class", "scratch-nmtui", "-e", "nmtui"]).catch(() => {})}>
            {/* nf-fa-wifi when online, nf-fa-chain_broken otherwise (AstalNetwork.State enum) */}
            <label label={createBinding(net, "state")(st => st === Network.State.CONNECTED_GLOBAL ? "\u{f1eb}" : "\u{f127}")} />
          </button>
          <button class={dnd(d => d ? "on" : "")}
            onClicked={() => { setDnd(d => !d); execAsync(["swaync-client", "-d", "-sw"]).catch(() => {}) }}>
            <label label={"\u{f0f3}"} />
          </button>
          {/* shell-backed pills (Toggle.tsx): game-mode · caffeine · airplane · raw input */}
          <Toggle icon={"\u{f11b}"} probe="[ -e ~/.cache/game-mode ] && echo 1" action={n => `game-mode ${n ? "on" : "off"}`} />
          <Toggle icon={"\u{f0f4}"} probe="[ -f ~/.cache/caffeine.pid ] && kill -0 $(cat ~/.cache/caffeine.pid) 2>/dev/null && echo 1"
                  action={n => n ? "systemd-inhibit --what=idle --who=ags --why=caffeine sleep infinity >/dev/null 2>&1 & echo $! > ~/.cache/caffeine.pid"
                                 : "kill $(cat ~/.cache/caffeine.pid) 2>/dev/null; rm -f ~/.cache/caffeine.pid"} />
          <Toggle icon="✈" probe="nmcli radio wifi | grep -q disabled && echo 1" action={n => `nmcli radio all ${n ? "off" : "on"}`} />
          <Toggle icon={"\u{f245}"} probe="hyprctl getoption input:accel_profile -j | grep -q flat && echo 1"
                  action={n => `hyprctl eval "hl.config({ input = { accel_profile = '${n ? "flat" : "adaptive"}' } })"`} />
        </box>
        {/* power profile */}
        <box spacing={8}>
          <label label="power" />
          <label hexpand halign={2} label={createBinding(pp, "activeProfile")} />
          <button onClicked={() => pp.set_active_profile(
            pp.activeProfile === "performance" ? "balanced" : "performance")}>
            <label label="⇄" />
          </button>
        </box>
        {/* adaptive light↔dark + night-light — writes `sun policy`; the sun module renders (theming.md) */}
        <box spacing={8}>
          <label label="sun" />
          {(["auto", "light", "dark"] as const).map(m =>
            <button hexpand class={pol(p => p === m ? "on" : "")}
              onClicked={() => { setPol(m); execAsync(["sun", "policy", m]).catch(() => {}) }}>
              <label label={m} />
            </button>)}
        </box>
      </box>
    </window>
  )
}
