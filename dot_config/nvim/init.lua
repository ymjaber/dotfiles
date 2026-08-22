vim.g.mapleader, vim.g.maplocalleader = " ", " "
require("config.options")
require("config.keymaps")

if not vim.g.vscode then
  require("config.autocmds")
  require("config.lazy") -- plugins only outside VS Code (it renders its own UI)
end
