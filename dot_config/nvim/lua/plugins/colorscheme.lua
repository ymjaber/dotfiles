-- plugins/colorscheme.lua
-- WHY: catppuccin (catppuccin/nvim — date-checked 2026-08-29: active, not archived, pushed
-- 2026-08-09, Neovim ≥ 0.8, `auto_integrations` detects the slate under lazy.nvim). The theme
-- engine's palette goes in through color_overrides (config/colorscheme.lua), so a new seed or a
-- wallpaper change re-themes the editor like every other surface (theming.md).
-- lazy = false + priority = 1000 is lazy.nvim's rule for colorschemes: load first, before any UI;
-- `name = "catppuccin"` is the plugin's own recommended spec (the repo is called `nvim`).
return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function() require("config.colorscheme").apply() end,
}
