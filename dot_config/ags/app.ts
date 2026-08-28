import app from "ags/gtk4/app"
import style from "./style/main.scss"   // ⚠ compiled by `sass` at bundle time — package dart-sass (roster above)
import Bar from "./widget/Bar"
import GLib from "gi://GLib"

// ⚠ Colours are NOT compiled in. main.scss only uses var(--bg) & co.; the values live in
// style/colors.css, a theme-engine render target (theming.md), loaded at RUNTIME with
// app.apply_css — so `theme set` recolours the bar with one `ags request recolor`, no rebuild,
// exactly the swaync pattern (GTK4 `:root` variables). Providers stack at the same priority and
// the newest wins; `reset=true` is deliberately not used — it would drop the bundled main.css too.
const COLORS = GLib.get_home_dir() + "/.config/ags/style/colors.css"
const recolor = () => { if (GLib.file_test(COLORS, GLib.FileTest.EXISTS)) app.apply_css(COLORS) }

app.start({
  css: style,
  main() {
    recolor()   // first paint; absent until the first `theme set` on a new account — the bar still renders, unthemed
    // One call per widget (the overlay contract). Nothing registers here: a <window> registers
    // itself via application={app}, which is what `ags toggle <name>` looks up.
    // ⚠ Bar() is one window on the compositor-chosen output. Per-output bars are the template's
    // `app.get_monitors().map(Bar)` — only once Bar takes `gdkmonitor: Gdk.Monitor` and pins it.
    Bar()
  },
  // `ags request recolor` from theme's reload(); anything else answers so the CLI never hangs
  requestHandler(argv, res) {
    if (argv[0] === "recolor") { recolor(); res("ok") } else res(`unknown request: ${argv.join(" ")}`)
  },
})
