// widget/Mixer.tsx  (verified: AstalWp.Audio has streams, recorders, speakers, microphones)
import { createBinding, For } from "ags"
import Wp from "gi://AstalWp"
export default function Mixer() {
  // ⚠ ts-for-gir types GLib.List-backed Astal properties as `T[] | null` — coalesce once, at the binding.
  const streams = createBinding(Wp.get_default()!.audio, "streams")(l => l ?? [])
  // ⚠ Lists are never mapped inline (an Accessor child renders as one static label) — <For> keys each stream.
  return <box orientation={1} class="mixer" spacing={6}>
    <For each={streams}>
      {s => <box spacing={8}>
        <label label={createBinding(s, "description")(d => (d || "app").slice(0, 18))} widthChars={18} xalign={0} />
        {/* ⚠ change-value's NEW value is its 3rd argument; return false so GTK still applies it to the slider. */}
        <slider hexpand value={createBinding(s, "volume")} onChangeValue={(_self, _scroll, v) => { s.set_volume(v); return false }} />
      </box>}
    </For>
    <label label="no apps playing" visible={streams(l => l.length === 0)} />
  </box>
}
