return {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {
        -- What to save in the session file
        options = {
            'buffers',  -- Save open buffer list
            'curdir',   -- Save current working directory
            'tabpages', -- Save tab page layout
            'winsize',  -- Save window sizes
            'help',     -- Save help window state
            'globals',  -- Save global variables (UPPERCASE_VARS)
            'skiprtp',  -- Don't save runtime path (portable)
        },
    },

    keys = {
        {
            '<leader>as',
            function()
                require('persistence').load()
            end,
            desc = 'Restore Session',
        },
        {
            '<leader>al',
            function()
                require('persistence').load({ last = true })
            end,
            desc = 'Restore Last Session',
        },
        {
            '<leader>ad',
            function()
                require('persistence').stop()
            end,
            desc = 'Don not Save Current Session',
        },
    },
}
