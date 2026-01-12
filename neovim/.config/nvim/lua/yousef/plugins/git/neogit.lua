return {
    'NeogitOrg/neogit',
    cmd = 'Neogit',

    dependencies = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim',
        'ibhagwan/fzf-lua',
    },
    keys = {
        { '<leader>gn', '<cmd>Neogit<cr>',        desc = 'Neogit' },
        { '<leader>gc', '<cmd>Neogit commit<cr>', desc = 'Neogit Commit' },
        { '<leader>gp', '<cmd>Neogit push<cr>',   desc = 'Neogit Push' },
        { '<leader>gl', '<cmd>Neogit pull<cr>',   desc = 'Neogit Pull' },
    },
}
