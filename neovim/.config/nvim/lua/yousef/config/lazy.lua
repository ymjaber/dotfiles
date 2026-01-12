local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Dynamically import all subdirectories in plugins folder
local function get_plugin_imports()
  local imports = {}
  local plugins_path = vim.fn.stdpath('config') .. '/lua/yousef/plugins'

  for name, type in vim.fs.dir(plugins_path) do
    if type == 'directory' then
      table.insert(imports, { import = 'yousef.plugins.' .. name })
    end
  end

  return imports
end

require('lazy').setup({
  spec = get_plugin_imports(),
  install = { colorscheme = { 'catppuccin', 'habamax' } },
  checker = { enabled = true, notify = false },
})

