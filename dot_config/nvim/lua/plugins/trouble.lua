-- plugins/trouble.lua
-- WHY: a clean list UI for diagnostics/references/quickfix (v3) — complements the picker.
return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = { focus = true },
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "diagnostics" },
    { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "quickfix" },
  },
}
