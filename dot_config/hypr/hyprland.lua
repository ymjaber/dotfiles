-- ~/.config/hypr/hyprland.lua ← dot_config/hypr/hyprland.lua
local H = os.getenv("HOME") .. "/.config/hypr/"

-- SECTION input — A5: SUPER+Space toggles us↔ara (why the launcher lives on SUPER+D).
-- First listed layout is the one binds resolve against.
hl.config({
  input   = { kb_layout = "us,ara", kb_options = "grp:win_space_toggle",
              follow_mouse = 1, touchpad = { natural_scroll = true } },
  general = { gaps_in = 4, gaps_out = 8, border_size = 2, layout = "dwindle" },
  decoration = { rounding = 8 },
  misc    = { disable_hyprland_logo = true,
              enable_anr_dialog = true,               -- "app not responding" dialog, not a frozen tile
              allow_session_lock_restore = true,      -- hyprlock survives resume-from-suspend
              enable_swallow = true, swallow_regex = "^(kitty)$" }, -- GUI from a term hides the term
  debug   = { vfr = true },          -- vfr is a DEBUG key, not misc; misc.vrr is adaptive sync
  cursor  = { zoom_factor = 1.0 },   -- magnifier baseline; the zoom script steps it (pass 2)
})

-- SECTION monitors — empty output = fallback for any monitor. "auto" scale, never a literal.
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

-- SECTION theme — written by theming.md's engine; guarded so a missing file never breaks login
pcall(dofile, H .. "theme.lua")

-- SECTION binds — THIS BLOCK IS THE KEYBINDING TABLE. Every bind carries a description, which
-- `hyprctl binds -j` reads back; that is what feeds the cheatsheet in pass 2.
local bind = hl.bind
-- Plain exec: uwsm is gone (2026-08-27) and with it the app wrapper. Per-app scopes bought nothing here —
-- `oomctl` manages 0 cgroups on this machine, so oomd had no targets either way (see setup/04).
bind("SUPER + Return", hl.dsp.exec_cmd("kitty"),         { description = "terminal" })
bind("SUPER + D",      hl.dsp.exec_cmd("rofi -show drun"),       { description = "launcher" })  -- drun, NOT combi
bind("SUPER + Q",      hl.dsp.window.close(),                        { description = "close window" })
bind("SUPER + E",      hl.dsp.exec_cmd("kitty -e yazi"), { description = "files" })
bind("SUPER + B",      hl.dsp.exec_cmd("firefox"),   { description = "browser" })
-- the AGS panels (widgets.md): toggled by name — application={app} on the window is what makes the name resolve
bind("SUPER + SHIFT + C", hl.dsp.exec_cmd("ags toggle control-center"), { description = "control centre" })
bind("SUPER + SHIFT + D", hl.dsp.exec_cmd("ags toggle dashboard"),      { description = "dashboard" })
bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("grimblast --freeze save area - | satty -f -"),
                                                                     { description = "region shot → annotate" })
bind("SUPER + P",      hl.dsp.exec_cmd("hyprpicker -a"),             { description = "color picker" })
bind("SUPER + F",      hl.dsp.window.fullscreen({ action = "toggle" }), { description = "fullscreen" })
bind("SUPER + SHIFT + F", hl.dsp.window.float({ action = "toggle" }),   { description = "float" })
-- pass 1 points at the hyprlock binary; pass 2 swaps in the `lock` wrapper
bind("SUPER + Escape",         hl.dsp.exec_cmd("lock"),          { description = "lock" })


bind("SUPER + SHIFT + Escape", hl.dsp.exec_cmd("menu-power"),    { description = "power menu" })
bind("SUPER + V",      hl.dsp.exec_cmd("menu-clipboard"),        { description = "clipboard history" })
bind("SUPER + SHIFT + backslash", hl.dsp.exec_cmd("menu-filter"), { description = "screen filter (grayscale/colorblind/OLED)" })
bind("SUPER + W",      hl.dsp.exec_cmd("menu-wifi"),             { description = "wifi" })
bind("SUPER + SHIFT + N", hl.dsp.exec_cmd("sun temp toggle"), { description = "night-light toggle" })
-- calc and emoji are rofi PLUGIN MODES, not scripts. They also appear as tabs inside SUPER+D.
bind("SUPER + C",      hl.dsp.exec_cmd("rofi -show calc"),       { description = "calculator" })
bind("SUPER + period", hl.dsp.exec_cmd("rofi -show emoji"),      { description = "emoji picker" })
bind("SUPER + slash",     hl.dsp.exec_cmd("cheatsheet"),         { description = "keybind cheatsheet" })
bind("SUPER + SHIFT + G", hl.dsp.exec_cmd("game-mode toggle"),   { description = "game/performance mode" })
bind("SUPER + Tab",       hl.dsp.exec_cmd("rofi -show window"),  { description = "window switcher" })
bind("SUPER + grave",     hl.dsp.exec_cmd("scratch term"),       { description = "dropdown terminal" })
bind("SUPER + SHIFT + O", hl.dsp.exec_cmd("ocr"),                { description = "screenshot → OCR" })
bind("SUPER + equal",     hl.dsp.exec_cmd("zoom in"),    { description = "zoom in",  repeating = true })
bind("SUPER + minus",     hl.dsp.exec_cmd("zoom out"),   { description = "zoom out", repeating = true })
bind("SUPER + 0",         hl.dsp.exec_cmd("zoom reset"), { description = "zoom reset" })
bind("SUPER + R",         hl.dsp.submap("resize"),       { description = "resize mode (submap)" })
bind("SUPER + SHIFT + P", hl.dsp.submap("pass"),         { description = "pass-through: VM/game grabs all keys" })






-- vim motions: one grammar everywhere
for k, d in pairs({ h = "l", j = "d", k = "u", l = "r" }) do
  bind("SUPER + " .. k:upper(),         hl.dsp.focus({ direction = d }),       { description = "focus " .. d })
  bind("SUPER + SHIFT + " .. k:upper(), hl.dsp.window.move({ direction = d }), { description = "move " .. d })
end
-- workspaces: Lua earning its keep — 18 binds from one loop
for i = 1, 9 do
  bind("SUPER + " .. i,         hl.dsp.focus({ workspace = i }),       { description = "workspace " .. i })
  bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }), { description = "send to " .. i })
end
-- hardware keys: locked = still work on the lockscreen; repeating = hold-to-repeat
-- -l 1.0 caps at 100%: without it a held key drives PipeWire gain past unity into clipping
bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise --max-volume 150"), { locked = true, repeating = true })
bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"), { locked = true, repeating = true })
bind("XF86AudioMute",        hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true })
bind("XF86AudioMicMute",     hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"), { locked = true })
bind("XF86AudioPlay",        hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("swayosd-client --brightness raise"), { locked = true, repeating = true })
bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("swayosd-client --brightness lower"), { locked = true, repeating = true })
bind("SUPER + N", hl.dsp.exec_cmd("swaync-client -t -sw"), { description = "notification centre" })

-- LAW: never do blocking work inside a bind *function* — exec_cmd runs outside the event loop.
-- Exit goes through menu-power: hyprshutdown if installed (closes apps gracefully first), else hl.dsp.exit().

-- SECTION rules — float applets, auto-PiP, dim modal choosers, keep video awake, hide the
-- screenshare bridge, and blur behind our own layer-shell surfaces.
-- ⚠ A rule VALUE may only be string, bool or number — a Lua table is rejected outright, so a
-- size is "25% 25%", never { "25%", "25%" }. `name` is what `hyprctl` lists the rule by.
local wr = hl.window_rule
wr({ name = "float-applets", float = true,
     match = { class = "^(blueman-manager|nm-connection-editor|org.pulseaudio.pavucontrol|pavucontrol)$" } })
wr({ name = "pip", float = true, pin = true, size = "25% 25%", move = "72% 72%",
     match = { title = "^(Picture-in-Picture)$" } })
wr({ name = "dim-modals", dim_around = true,
     match = { class = "^(xdg-desktop-portal-gtk|.*[Pp]olkit.*)$" } })
wr({ name = "video-awake",   idle_inhibit = "focus",      match = { class = "^(mpv|celluloid)$" } })
wr({ name = "browser-awake", idle_inhibit = "fullscreen", match = { class = "^(firefox|Brave-browser|chromium)$" } })
wr({ name = "hide-xwayland-bridge", no_focus = true, opacity = 0.0,
     match = { class = "^(xwaylandvideobridge)$" } })
-- the scratch terminal's geometry lives HERE, not inline in the exec: hl.exec_cmd's
-- rules-table form returns ok and spawns NOTHING. Hyprland applies this at map time.
-- ⚠ per-class: a second scratchpad (`scratch notes`) needs its own rule line.
wr({ name = "scratch", float = true, size = "70% 55%", center = true,
     match = { class = "^scratch-.*$" } })
-- ⚠ layer_rule has NO `rule` and NO top-level `namespace`: effects are named keys, and the
-- namespace is a MATCH key. The Lua field is ignore_alpha, not the .conf-era "ignorealpha 0.5".
for _, ns in ipairs({ "rofi", "bar", "control-center", "osd", "dashboard", "cheatsheet",
                      "swaync-control-center", "swaync-notification-window" }) do
  hl.layer_rule({ name = "blur-" .. ns, match = { namespace = "^" .. ns .. "$" },
                  blur = true, ignore_alpha = 0.5 })
end

-- SECTION events — center oversized floats on open.
-- ⚠ hl.dsp.* are dispatcher FACTORIES: they return a userdata object, they do not run
-- anything. In a bind that object is the payload; in a callback it is discarded — so the
-- immediate form is hl.dispatch(<dispatcher>).
hl.on("window.open", function(w) if w and w.floating then hl.dispatch(hl.dsp.window.center()) end end)
hl.on("config.reloaded", function() hl.exec_cmd("game-mode reapply") end)

-- SECTION gestures — 3-finger workspace swipe, 4-finger pinch-fullscreen.
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 4, direction = "pinchout",
             action = function() hl.dispatch(hl.dsp.window.fullscreen({ action = "toggle" })) end })

-- SECTION submaps — resize is a leader mode; "pass" forwards ALL keys to a VM/game.
-- ⚠ The define_submap callback receives NO arguments: call plain hl.bind inside it and the
-- binds attach to the submap. ⚠ window.resize takes { x, y, relative } — no direction/step.
hl.define_submap("resize", function()
  for k, xy in pairs({ h = { -40, 0 }, j = { 0, 40 }, k = { 0, -40 }, l = { 40, 0 } }) do
    hl.bind(k, hl.dsp.window.resize({ x = xy[1], y = xy[2], relative = true }), { repeating = true })
  end
  hl.bind("Escape", hl.dsp.submap("reset")); hl.bind("Return", hl.dsp.submap("reset"))
end)
hl.define_submap("pass", function() hl.bind("SUPER + SHIFT + P", hl.dsp.submap("reset")) end)
hl.on("keybinds.submap", function(name)
  name = name or ""
  local hints = { resize = "hjkl resize · esc done", pass = "all keys → app · SUPER+SHIFT+P exits" }
  if hints[name] then hl.exec_cmd("notify-send -t 2500 -a hypr '" .. name .. " mode' '" .. hints[name] .. "'") end
end)

-- SECTION autostart — RESTORED 2026-08-27 (see § Why `exec-once` and not units).
-- ⚠⚠ The exec-once mechanism is the `hyprland.start` EVENT, not a function. The shipped example
-- (/usr/share/hypr/hyprland.lua:45) does autostart exactly this way. A TOP-LEVEL hl.exec_cmd is
-- not once: this file re-executes on every `hyprctl reload` (which game-mode calls), and a bare
-- exec_cmd appending to a file gave one line per reload — 1 → 2 → 3, measured 2026-08-27. Inside
-- the start handler it fires once per compositor start and never on reload (verified against the
-- v0.56.2 source: emitted once behind a static guard; reload emits only config.reloaded).
hl.on("hyprland.start", function()
  -- ⚠⚠ ONE chained command, because exec_cmd is async and the ORDER is the whole point:
  --  1. import the session env into D-Bus and systemd. xdg-desktop-portal and every other
  --     D-Bus/systemd-activated service is NOT a child of the compositor and inherits nothing
  --     from it; uwsm used to do this import. Without it: no screenshare, no file pickers.
  --  2. THEN start, through their UNITS, the daemons that ship D-Bus activation files.
  --     LAW: if /usr/share/dbus-1/services/*.service names `SystemdService=X`, start X and
  --     never exec the binary — D-Bus starts X the moment anyone calls the bus name, and the
  --     two instances race. Measured 2026-08-27: "An instance of SwayNotificationCenter is
  --     already running!" ×5 → start-limit-hit → one "Failed unit" toast, three "recovered".
  --     `disable` does NOT prevent activation. Starting the unit makes systemd the single
  --     owner, keeps Restart=on-failure and ExecReload, and stays KDE-safe because the units
  --     are disabled from the target. Step 1 is what hands them WAYLAND_DISPLAY. None of the
  --     three has Requisite=, so this works with graphical-session.target inactive.
  --     swaync (two names) · hyprpolkitagent (which also has NO binary on PATH — its unit knows
  --     the path) · blueman-applet. Find yours: grep -l SystemdService /usr/share/dbus-1/services/*
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE HYPRLAND_INSTANCE_SIGNATURE && systemctl --user start swaync.service hyprpolkitagent.service blueman-applet.service")

  -- everything below ships no D-Bus activation, so a plain exec has no one to race
  for _, c in ipairs({
    -- the bar is AGS since 2026-08-29 (widgets.md); waybar is retired
    "ags run", "hypridle", "hyprsunset", "swayosd-server",
    "wl-paste --type text  --watch cliphist store",
    "wl-paste --type image --watch cliphist store",
    "monitor-watch", "power-profile-watch", "bt-audio-switch",
    -- ⚠ XDG autostart is NOT run for us any more — uwsm's wayland-session-xdg-autostart@ target
    -- was what started these. Dropping uwsm REVERSES the 2026-08-16 finding that deleted
    -- nm-applet from this list as a duplicate. It is no longer a duplicate.
    "nm-applet --indicator", "jetbrains-toolbox --minimize", "limine-snapper-notify",
  }) do hl.exec_cmd(c) end

  -- ⚠ the one ordering dependency: `wallpaper` talks to awww-daemon over its socket. Racing them
  -- means no wallpaper whenever `wallpaper` wins. Chain, don't race.
  hl.exec_cmd("sh -c 'awww-daemon & until awww query >/dev/null 2>&1; do sleep 0.1; done; wallpaper'")
end)

-- SECTION shutdown — the teardown that exec-once does not give for free.
-- When the compositor exits, every client we exec'd loses its socket mid-call. Measured
-- 2026-08-27: awww-daemon and hyprsunset died by SIGABRT and the portal by SIGSEGV in the same
-- second as the logout — three coredumps, which drkonqi turned into sixteen and a "18 failed
-- units" toast. Units had PartOf=graphical-session.target for this; we send SIGTERM first
-- instead. Wiki: the event is "emitted once before Hyprland exiting". The spawn is async, so
-- verify after a logout: `coredumpctl list --since -5min` should be empty.
-- ⚠ pkill/pgrep -x compare against comm, which is 15 characters — power-profile-watch is
-- "power-profile-w" there and never matches. The bash watchers are matched on their path with -f.
hl.on("hyprland.shutdown", function()
  hl.exec_cmd("ags quit; systemctl --user stop swaync.service hyprpolkitagent.service blueman-applet.service xdg-desktop-portal-hyprland.service; "
    .. "pkill -x -u \"$(id -u)\" 'hypridle|hyprsunset|swayosd-server|awww-daemon|nm-applet|wl-paste'; "
    .. "pkill -f -u \"$(id -u)\" -- 'bin/(monitor-watch|power-profile-watch|bt-audio-switch|limine-snapper-notify)$|jetbrains-toolbox'")
end)

-- OVERLAY MANIFEST — use-case folders append ONE line each; nothing else in base changes.
for _, m in ipairs({
  -- "modules/servers.lua",
  -- "modules/deen.lua",
}) do pcall(dofile, H .. m) end
