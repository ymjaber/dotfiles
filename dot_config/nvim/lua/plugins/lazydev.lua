-- plugins/lazydev.lua
-- WHY: real Lua LSP for editing THIS config — types for vim.* and plugin modules, fed
-- into blink. Loads only for lua files.
return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } },
}
