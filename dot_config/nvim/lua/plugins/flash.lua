-- plugins/flash.lua
-- WHY: jump anywhere on screen by label (supersedes easymotion/leap); enhances f/t + search.
return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function() require("flash").jump() end,
      desc = "flash jump",
    },
    {
      "S",
      mode = { "n", "x", "o" },
      function() require("flash").treesitter() end,
      desc = "flash treesitter",
    },
  },
}
