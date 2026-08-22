-- plugins/oil.lua
-- WHY: edit directories as buffers — rename/move/delete are text edits, :w applies.
-- yazi.nvim = the full TUI file manager as a floating bridge for bulk/visual work.
return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {
      default_file_explorer = true,
      view_options = { show_hidden = true },
      keymaps = { ["<C-h>"] = false },
    },
  },
  {
    "mikavilpas/yazi.nvim",
    keys = {
      {
        "<leader>E",
        function() require("yazi").yazi() end,
        desc = "yazi (float)",
      },
    },
    opts = { open_for_directories = false },
  },
}
