// widget/Bar.tsx — Waybar parity (2026-08-28): the same module set, left/center/right, from Astal.
// ⚠ ICONS ARE ESCAPES (see ControlCenter). Comments on their OWN lines, never after an element.
import app from "ags/gtk4/app"
import { createBinding, createState, For, onCleanup } from "ags"
import { createPoll } from "ags/time"
import { execAsync, subprocess } from "ags/process"
import { Astal, Gtk } from "ags/gtk4"
import Pango from "gi://Pango"
import AstalHyprland from "gi://AstalHyprland"
import AstalBattery from "gi://AstalBattery"
import AstalWp from "gi://AstalWp"
import AstalNetwork from "gi://AstalNetwork"
import AstalBluetooth from "gi://AstalBluetooth"
import AstalTray from "gi://AstalTray"
// the four bar indicators (§ Bar indicators) — components, not windows: they live in the end box
import Privacy from "./Privacy"
import Updates from "./Updates"
import Recorder from "./Recorder"
import Cava from "./Cava"
// ⚠ Every file that anchors a <window> needs these two lines (imports stay first, the destructure
// follows them). Without them TOP/LEFT/RIGHT are undefined — the 2026-08-09 draft had no such import.
const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

// "English (US)" → us · "Arabic" → ar — what waybar's hyprland/language showed
const short = (l: string) => /english/i.test(l) ? "us" : /arabic/i.test(l) ? "ar" : l.slice(0, 2).toLowerCase()

export default function Bar() {
  const hypr = AstalHyprland.get_default()
  const bat = AstalBattery.get_default()
  const audio = AstalWp.get_default()!.audio
  const net = AstalNetwork.get_default()
  const bt = AstalBluetooth.get_default()
  const tray = AstalTray.get_default()

  // LEFT — workspaces sorted by id (.active on the focused one), the submap name, the window title.
  // ⚠ createBinding takes a nested path: ("focusedClient", "title") re-binds to the new client on
  // focus change AND follows that client's title notifies — a one-level binding would go stale.
  const workspaces = createBinding(hypr, "workspaces")(ws => [...ws].sort((a, b) => a.id - b.id))
  const focusedId = createBinding(hypr, "focusedWorkspace", "id")
  const title = createBinding(hypr, "focusedClient", "title")
  const [submap, setSubmap] = createState("")
  const [layout, setLayout] = createState("")
  // signals: keyboard-layout(keyboard, layout) and submap(name) — no property to bind, so state + connect
  const s1 = hypr.connect("submap", (_h, name: string) => setSubmap(name))
  const s2 = hypr.connect("keyboard-layout", (_h, _kb: string, l: string) => setLayout(short(l)))
  onCleanup(() => { hypr.disconnect(s1); hypr.disconnect(s2) })
  // the signal only fires on change — seed from hyprctl once
  execAsync(["hyprctl", "devices", "-j"])
    .then(j => { const k = (JSON.parse(j).keyboards as { main: boolean; active_keymap: string }[]).find(k => k.main); if (k) setLayout(short(k.active_keymap)) })
    .catch(() => {})

  // CENTER
  const time = createPoll("", 1000, "date '+%a %d · %H:%M'")

  // RIGHT — notifications (swaync's own subscribe stream, the same JSON waybar's custom module read),
  // audio, network, bluetooth, battery from Astal bindings; icons are the desktop's symbolic set.
  const [notif, setNotif] = createState({ cls: "none", count: 0 })
  const proc = subprocess(["swaync-client", "-swb"], line => {
    try { const j = JSON.parse(line); setNotif({ cls: String(j.class ?? "none"), count: Number(j.text) || 0 }) } catch {}
  })
  onCleanup(() => proc.kill())
  const speaker = audio.default_speaker
  const volIcon = createBinding(speaker, "volumeIcon")
  const vol = createBinding(speaker, "volume")
  const netIcon = net.wifi ? createBinding(net.wifi, "iconName") : net.wired ? createBinding(net.wired, "iconName") : "network-offline-symbolic"
  const btOn = createBinding(bt, "isPowered")
  const btConnected = createBinding(bt, "isConnected")
  const batIcon = createBinding(bat, "batteryIconName")
  const pct = createBinding(bat, "percentage")
  // ⚠ hoisted on purpose: written inline as each={createBinding(tray, "items")}, TypeScript resolves
  // <For>'s generics before the call's overloads, the item becomes `unknown`, and every binding
  // inside the row degrades to the widest overload — 10 errors from one expression (2026-08-28).
  const trayItems = createBinding(tray, "items")

  return (
    <window visible name="bar" namespace="bar" class="bar" application={app} anchor={TOP | LEFT | RIGHT} exclusivity={Astal.Exclusivity.EXCLUSIVE}>
      {/* ⚠ `visible`: GTK4 windows construct hidden. Enum form per the shipped template. */}
      <centerbox>
        <box $type="start" spacing={6}>
          <box class="workspaces">
            <For each={workspaces} id={w => w.id}>
              {w => <button class={focusedId(id => id === w.id ? "active" : "")} onClicked={() => w.focus()}>
                <label label={String(w.id)} />
              </button>}
            </For>
          </box>
          <label class="submap" visible={submap(m => !!m)} label={submap} />
          <label class="title" label={title(t => t ?? "")} maxWidthChars={48} ellipsize={Pango.EllipsizeMode.END} />
        </box>
        <label $type="center" label={time} />
        <box $type="end" spacing={6}>
          <For each={trayItems} id={i => i.itemId}>
            {item => <menubutton class="tray-item" menuModel={createBinding(item, "menuModel")} tooltipMarkup={createBinding(item, "tooltipMarkup")}
                $={self => { self.insert_action_group("dbusmenu", item.actionGroup); onCleanup(createBinding(item, "actionGroup").subscribe(() => self.insert_action_group("dbusmenu", item.actionGroup))) }}>
              <image gicon={createBinding(item, "gicon")} />
            </menubutton>}
          </For>
          <button class={notif(n => "notif " + (n.cls.startsWith("dnd") ? "dnd" : n.count > 0 ? "on" : ""))} onClicked={() => execAsync(["swaync-client", "-t", "-sw"]).catch(() => {})}>
            <label label={notif(n => n.cls.startsWith("dnd") ? "\u{f1f6}" : "\u{f0f3}")} />
          </button>
          <Privacy />
          <Recorder />
          <Updates />
          <label class="module" label={layout} />
          <box class="module" spacing={4}>
            <image iconName={volIcon} />
            <label label={vol(v => `${Math.round(v * 100)}%`)} />
          </box>
          <image class="module" iconName={netIcon} />
          <image class={btConnected(c => "module" + (c ? " on" : ""))} visible={btOn} iconName="bluetooth-active-symbolic" />
          <box class={pct(p => "module" + (p < 0.1 ? " err" : p < 0.2 ? " warn" : ""))} spacing={4}>
            <image iconName={batIcon} />
            <label label={pct(p => `${Math.round(p * 100)}%`)} />
          </box>
          <Cava />
        </box>
      </centerbox>
    </window>
  )
}
