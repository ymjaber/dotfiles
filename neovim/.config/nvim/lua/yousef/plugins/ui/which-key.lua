return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
        vim.o.timeout = true     -- Enable timeout for key sequences
        vim.o.timeoutlen = 750   -- Wait 750ms before showing popup
    end,

    config = function()
        local wk = require('which-key')
        wk.setup({ preset = 'modern' })
        wk.add({
            { '<leader>t', group = 'Tabs' },
            { '<leader>u', group = 'Toggle' },
            { '<leader>x', group = 'Diagnostics' },
            { '<leader>b', group = 'Buffers' },
            { '<leader>s', group = 'Windows' },
            { '<leader>f', group = 'Fuzzy find' },
            { '<leader>g', group = 'Git' },
            { '<leader>w', group = 'File' },
        })
    end,

    keys = {
        {
            '<leader>?',
            function()
                require('which-key').show({ global = false })
            end,
            desc = 'Buffer local keymaps',
        },
    },
}

