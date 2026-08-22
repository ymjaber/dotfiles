-- plugins/snacks.lua
-- WHY: picker (supersedes telescope) + lazygit toggle + the QoL bundle that replaces four
-- separate plugins (indent/notifier/dashboard/input). One plugin, one config surface.
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    picker = { enabled = true },
    lazygit = { enabled = true },
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    indent = { enabled = true },
    notifier = { enabled = true },
    input = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    dashboard = { enabled = true },
  },
}
