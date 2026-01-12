return {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    cmd = 'CopilotChat',
    dependencies = {
        { 'zbirenbaum/copilot.lua' },
        { 'nvim-lua/plenary.nvim' },
    },

    keys = {
        { '<leader>a',  '',                           desc = 'AI chat' },
        { '<leader>ao', '<cmd>CopilotChatOpen<cr>',   desc = 'Open Chat' },
        { '<leader>aq', '<cmd>CopilotChatClose<cr>',  desc = 'Close Chat' },
        { '<leader>at', '<cmd>CopilotChatToggle<cr>', desc = 'Toggle Chat' },
        { '<leader>ar', '<cmd>CopilotChatReset<cr>',  desc = 'Reset Chat' },
        {
            '<leader>ae',
            function()
                local input = vim.fn.input('Quick Chat: ')
                if input ~= "" then
                    -- Ask with entire buffer as context
                    require('CopilotChat').ask(input, {
                        selection = require('CopilotChat.select').buffer,
                    })
                end
            end,
            desc = 'Quick Chat (Buffer)',
        },

        -- ====================================================================
        -- Built-in Prompts (work on selection in visual mode)
        -- ====================================================================

        { '<leader>ap', '<cmd>CopilotChatExplain<cr>',  mode = { 'n', 'v' },             desc = 'Explain Code' },
        { '<leader>af', '<cmd>CopilotChatFix<cr>',      mode = { 'n', 'v' },             desc = 'Fix Code' },
        { '<leader>ad', '<cmd>CopilotChatDocs<cr>',     mode = { 'n', 'v' },             desc = 'Generate Docs' },
        { '<leader>aT', '<cmd>CopilotChatTests<cr>',    mode = { 'n', 'v' },             desc = 'Generate Tests' },
        { '<leader>aR', '<cmd>CopilotChatReview<cr>',   mode = { 'n', 'v' },             desc = 'Review Code' },
        { '<leader>as', '<cmd>CopilotChatOptimize<cr>', mode = { 'n', 'v' },             desc = 'Optimize Code' },
        { '<leader>am', '<cmd>CopilotChatCommit<cr>',   desc = 'Generate Commit Message' },
    },

    opts = {
        model = 'gpt-5.2',
        auto_follow_cursor = true,
        show_help = true,

        -- ====================================================================
        -- Message Headers
        -- ====================================================================
        -- Headers for different message types in chat
        question_header = '## User ',
        answer_header = '## Copilot ',
        error_header = '## Error ',

        -- ====================================================================
        -- Window Configuration
        -- ====================================================================
        window = {
            layout = 'vertical', -- Vertical split layout
            width = 0.35,        -- 35% of screen width
            height = 0.5,        -- 50% of screen height
            border = 'rounded',  -- Rounded border
            title = 'Copilot Chat',
        },

        -- ====================================================================
        -- Key Mappings (inside chat window)
        -- ====================================================================

        mappings = {
            -- Tab completion for @mentions and /commands
            complete = {
                detail = 'Use @<Tab> or /<Tab> for options.',
                insert = '<Tab>',
            },

            -- Close chat window
            close = {
                normal = 'q',
                insert = '<C-c>',
            },

            -- Reset conversation
            reset = {
                normal = '<C-r>',
                insert = '<C-r>',
            },

            -- Submit prompt to Copilot
            submit_prompt = {
                normal = '<CR>',
                insert = '<C-s>',
            },

            -- Accept suggested code diff
            accept_diff = {
                normal = '<C-y>',
                insert = '<C-y>',
            },

            -- Yank diff to clipboard
            yank_diff = {
                normal = 'gy',
            },

            -- Show diff preview
            show_diff = {
                normal = 'gd',
            },
        },
    },
}
