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
-- GUI apps go through `uwsm app` so each lands in its own scope in app-graphical.slice
-- instead of accumulating inside the compositor's own unit.
bind("SUPER + Return", hl.dsp.exec_cmd("uwsm app -- kitty"),         { description = "terminal" })
bind("SUPER + D",      hl.dsp.exec_cmd("rofi -show drun"),       { description = "launcher" })  -- drun, NOT combi
bind("SUPER + Q",      hl.dsp.window.close(),                        { description = "close window" })
bind("SUPER + E",      hl.dsp.exec_cmd("uwsm app -- kitty -e yazi"), { description = "files" })
bind("SUPER + B",      hl.dsp.exec_cmd("uwsm app -- firefox"),   { description = "browser" })
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
bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise --max-volume 100"), { locked = true, repeating = true })
bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"), { locked = true, repeating = true })
bind("XF86AudioMute",        hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true })
bind("XF86AudioMicMute",     hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"), { locked = true })
bind("XF86AudioPlay",        hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("swayosd-client --brightness raise"), { locked = true, repeating = true })
bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("swayosd-client --brightness lower"), { locked = true, repeating = true })
bind("SUPER + N", hl.dsp.exec_cmd("swaync-client -t -sw"), { description = "notification centre" })

-- LAW: never do blocking work inside a bind *function* — exec_cmd runs outside the event loop.
-- The exit() dispatcher is banned under uwsm; menu-power uses `uwsm stop` (pass 2).

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
for _, ns in ipairs({ "rofi", "bar", "control-center", "osd", "cheatsheet",
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

-- OVERLAY MANIFEST — use-case folders append ONE line each; nothing else in base changes.
for _, m in ipairs({
  -- "modules/servers.lua",
  -- "modules/deen.lua",
}) do pcall(dofile, H .. m) end
