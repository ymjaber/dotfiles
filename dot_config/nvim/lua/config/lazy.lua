local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local spec = {}
local function add(dir, mod)
  -- a directory earns an import only if it holds .lua files: lazy errors on an empty import
  if #vim.fn.globpath(dir, "*.lua", false, true) > 0 then
    table.insert(spec, { import = mod })
  end
  for _, d in ipairs(vim.fn.readdir(dir, function(n) return vim.fn.isdirectory(dir .. "/" .. n) end)) do
    add(dir .. "/" .. d, mod .. "." .. d)
  end
end
add(vim.fn.stdpath("config") .. "/lua/plugins", "plugins")
require("lazy").setup({ spec = spec, checker = { enabled = false } })
