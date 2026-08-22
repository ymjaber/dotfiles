-- plugins/undotree.lua
-- WHY: visualize + navigate the undo *tree* (undofile in options.lua makes it persistent).
return {
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  keys = { { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "undotree" } },
}
