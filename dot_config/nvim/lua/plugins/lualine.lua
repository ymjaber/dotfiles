-- plugins/lualine.lua
-- WHY: the statusline. lualine over mini.statusline/heirline — richest theme-engine palette
-- hook (theme="auto" tracks the colorscheme the engine sets).
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = { theme = "auto", globalstatus = true, section_separators = "", component_separators = "|" },
    sections = { lualine_c = { { "filename", path = 1 } }, lualine_x = { "diagnostics", "filetype" } },
  },
}
