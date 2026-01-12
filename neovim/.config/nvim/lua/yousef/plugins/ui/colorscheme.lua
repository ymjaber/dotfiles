return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup({
      flavour = 'mocha', -- Options: latte (light), frappe (medium light), macchiato (medium dark), mocha (dark)

      background = {
        light = 'latte',
        dark = 'mocha',
      },

      transparent_background = true, -- Use terminal's background color

      float = {
      transparent = true, -- Enable transparent floating windows
        solid = false, -- Don't use solid styling for floating windows
      },
      term_colors = true,

      integrations = {
        cmp = true,        -- nvim-cmp completion menu
        gitsigns = true,   -- Git signs in the gutter
        nvimtree = true,   -- File explorer
        treesitter = true, -- Syntax highlighting
        notify = true,     -- Notification popups
        telescope = true,  -- Fuzzy finder
        -- Full integrations reference: https://github.com/catppuccin/nvim#integrations
      },
    })

    -- Apply the colorscheme
    vim.cmd.colorscheme 'catppuccin'
  end,
}

