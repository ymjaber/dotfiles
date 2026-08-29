// widget/Media.tsx  (verified: <image file> intrinsic; AstalMpris.Player has cover-art, position,
// length — and libastal-mpris polls position itself (symbol astal_mpris_player_init_position_poll),
// so it is a binding, not a poll)
import { createBinding, With } from "ags"
import Mpris from "gi://AstalMpris"
export default function Media() {
  const mpris = Mpris.get_default()
  const players = createBinding(mpris, "players")
  // ⚠ An Accessor is never a JSX child (Gnim would render it as one static label) — <With> rebuilds the card per value.
  return <box class="media" visible={players(p => p.length > 0)}>
    <With value={players}>
      {ps => {
        const p = ps.find(x => x.playbackStatus === Mpris.PlaybackStatus.PLAYING) ?? ps[0]; if (!p) return <box />
        const pos = createBinding(p, "position")(x => (p.length ? x / p.length : 0))
        return <box spacing={10}>
          <image file={createBinding(p, "coverArt")} class="cover" />
          <box orientation={1} valign={3} hexpand>
            <label class="title" label={createBinding(p, "title")} maxWidthChars={24} ellipsize={3} />
            <label class="artist" label={createBinding(p, "artist")} />
            <box spacing={8}>
              <button onClicked={() => p.previous()}><label label="⏮" /></button>
              <button onClicked={() => p.play_pause()}>
                <label label={createBinding(p, "playbackStatus")(s => s === Mpris.PlaybackStatus.PLAYING ? "⏸" : "▶")} /></button>
              <button onClicked={() => p.next()}><label label="⏭" /></button>
            </box>
            {/* ⚠ change-value hands the NEW value as its 3rd argument (self.value is still the old one);
                return false so GTK's default handler still applies it to the slider. */}
            <slider value={pos} onChangeValue={(_self, _scroll, v) => { p.set_position(v * p.length); return false }} />
          </box>
        </box>
      }}
    </With>
  </box>
}
