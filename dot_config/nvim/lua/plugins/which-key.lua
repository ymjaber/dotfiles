-- plugins/which-key.lua
-- WHY: discoverability — the popup teaches the keymap spec as you type <leader>. v3 API.
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = {
      { "<leader>f", group = "find" },
      { "<leader>g", group = "git" },
      { "<leader>h", group = "hunk" },
      { "<leader>c", group = "code" },
      { "<leader>x", group = "diagnostics" },
      { "<leader>n", group = "notes" },
      { "<leader>a", group = "ai" },
    },
  },
}
