return {
    'folke/noice.nvim',
    event = 'VeryLazy',

    dependencies = {
        'MunifTanjim/nui.nvim',
        'rcarriga/nvim-notify',
    },

    opts = {
        -- ====================================================================
        -- Use default Neovim UI for cmdline and messages
        -- ====================================================================
        cmdline = { enabled = false },
        messages = { enabled = false },
        popupmenu = { enabled = false },
        notify = { enabled = false },

        -- ====================================================================
        -- LSP Integration
        -- ====================================================================
        lsp = {
            signature = {
                auto_open = { enabled = false },
            },
            -- Replace Neovim's default LSP handlers
            override = {
                -- Use noice's markdown rendering for LSP docs
                ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                ['vim.lsp.util.stylize_markdown'] = true,

                -- Use noice for completion item documentation
                -- Shows formatted docs in completion popup
                ['cmp.entry.get_documentation'] = true,
            },
        },

        -- ====================================================================
        -- Message Routes
        -- ====================================================================
        routes = {
            -- Route 1: Skip "No information available" hover messages (appear when hovering over tokens without docs)
            {
                filter = {
                    event = 'notify',                  -- Notification event
                    find = 'No information available', -- Message text
                },
                opts = { skip = true },                -- Don't show at all
            },

            -- Route 2: Show file write messages in mini view
            -- Matches "42L, 123B" (lines, bytes) messages
            {
                filter = {
                    event = 'msg_show',             -- Standard message event
                    any = {
                        { find = '%d+L, %d+B' },    -- "42L, 123B" format
                        { find = '; after #%d+' },  -- Undo/redo messages
                        { find = '; before #%d+' }, -- Undo/redo messages
                    },
                },
                view = 'mini', -- Show in small, unobtrusive popup
            },
        },

        -- ====================================================================
        -- Presets
        -- ====================================================================
        presets = {
            lsp_doc_border = true,
        },
    },

    keys = {
        -- Group indicator for which-key
        { '<leader>n', '', desc = '+noice' },
        {
            '<leader>nl',
            function()
                require('noice').cmd('last')
            end,
            desc = 'Last Message',
        },
        {
            '<leader>nh',
            function()
                require('noice').cmd('history')
            end,
            desc = 'History',
        },
        {
            '<leader>na',
            function()
                require('noice').cmd('all')
            end,
            desc = 'All Messages',
        },
        {
            '<leader>nd',
            function()
                require('noice').cmd('dismiss')
            end,
            desc = 'Dismiss All',
        },
        {
            '<S-Enter>',
            function()
                -- Get the current command being typed
                require('noice').redirect(vim.fn.getcmdline())
            end,
            mode = 'c', -- Command-line mode only
            desc = 'Redirect Cmdline',
        },
        {
            '<c-f>',
            function()
                -- scroll(4) scrolls 4 lines forward
                -- Returns false if nothing to scroll, falling back to default
                if not require('noice.lsp').scroll(4) then
                    return '<c-f>'
                end
            end,
            silent = true,
            expr = true,              -- Return value is used as keypress
            desc = 'Scroll Forward',
            mode = { 'i', 'n', 's' }, -- Insert, Normal, Select modes
        },

        {
            '<c-b>',
            function()
                -- scroll(-4) scrolls 4 lines backward
                if not require('noice.lsp').scroll(-4) then
                    return '<c-b>'
                end
            end,
            silent = true,
            expr = true,
            desc = 'Scroll Backward',
            mode = { 'i', 'n', 's' },
        },
    },
}
