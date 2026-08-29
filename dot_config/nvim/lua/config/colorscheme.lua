-- config/colorscheme.lua — the theme engine's palette, applied through catppuccin
-- (theming.md § render targets). `apply()` is also what the engine's reload() calls remotely.
local M = {}

local function luminance(hex)
  local r, g, b = tonumber(hex:sub(2, 3), 16) / 255, tonumber(hex:sub(4, 5), 16) / 255, tonumber(hex:sub(6, 7), 16) / 255
  return 0.2126 * r + 0.7152 * g + 0.0722 * b
end

function M.apply()
  package.loaded["theme"] = nil               -- re-read the fragment on every apply (reload path)
  local ok, c = pcall(require, "theme")
  if not ok then c = {} end                   -- no fragment yet (the first render is manual): pure Catppuccin
  -- light or dark is the background's luminance, not a flag: the palette has no mode key, and the
  -- -light/-dark seeds and matugen's `-m` both end up as a bright or a dark bg anyway.
  if c.bg then vim.o.background = luminance(c.bg) > 0.5 and "light" or "dark" end
  require("catppuccin").setup({
    flavour = "auto",                         -- latte when 'background' is light, mocha when dark
    background = { light = "latte", dark = "mocha" },
    term_colors = true,                       -- :terminal gets the palette too
    -- Normal's background becomes NONE, so the terminal's own background shows through — and
    -- that one already carries the engine's ALPHA (kitty's fragment, theming.md). Floats keep
    -- their solid surface (`float.transparent` stays false): a popup over translucent text needs
    -- an edge to read. Owner's call, 2026-08-29.
    transparent_background = true,
    auto_integrations = true,                 -- every plugin on the slate that catppuccin knows
    -- the nine slots → the Catppuccin names they are the official values of. A nil override is
    -- no override, so an empty `c` leaves Catppuccin untouched.
    color_overrides = { all = {
      base = c.bg, mantle = c.bg_alt, crust = c.bg_alt,
      text = c.fg, blue = c.accent, green = c.ok, yellow = c.warn, red = c.err,
      overlay0 = c.muted, surface0 = c.border,
    } },
  })
  vim.cmd.colorscheme("catppuccin")
  return true                                 -- --remote-expr wants a value back
end

return M
