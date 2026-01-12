return {
    -- ========================================================================
    -- PLUGIN: copilot.lua - Core Copilot Integration
    -- ========================================================================
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        event = 'InsertEnter',
        opts = {
            -- ================================================================
            -- Suggestion Configuration (ghost text)
            -- ================================================================

            suggestion = {
                enabled = true,
                auto_trigger = true,
                debounce = 75, -- Delay before triggering (ms)

                keymap = {
                    accept = '<M-l>',      -- Accept entire suggestion
                    accept_word = '<M-w>', -- Accept next word only
                    accept_line = '<M-j>', -- Accept current line only
                    next = '<M-]>',        -- Next suggestion
                    prev = '<M-[>',        -- Previous suggestion
                    dismiss = '<C-]>',     -- Dismiss current suggestion
                },
            },

            -- ================================================================
            -- Panel Configuration (full-screen view)
            -- ================================================================
            panel = {
                enabled = true,
                auto_refresh = false,
                keymap = {
                    jump_prev = '[c', -- Previous suggestion
                    jump_next = ']c', -- Next suggestion
                    accept = '<CR>',  -- Accept suggestion
                    refresh = 'gR',   -- Refresh suggestions
                    open = '<M-CR>',  -- Open panel
                },

                layout = {
                    position = 'bottom', -- Open at bottom
                    ratio = 0.4,         -- 40% of screen height
                },
            },

            -- ================================================================
            -- Filetype Configuration
            -- ================================================================

            filetypes = {
                yaml = false,      -- Disable for YAML (sensitive configs)
                markdown = true,   -- Enable for documentation
                help = false,      -- Disable for help files
                gitcommit = false, -- Disable for commit messages
                gitrebase = false, -- Disable for rebase
                hgcommit = false,  -- Disable for Mercurial
                svn = false,       -- Disable for SVN
                cvs = false,       -- Disable for CVS
                ['.'] = false,     -- Disable for dotfiles
            },
        },
    },

    -- ========================================================================
    -- PLUGIN: blink-copilot - Completion Integration
    -- ========================================================================
    {
        'fang2hou/blink-copilot',
        dependencies = { 'zbirenbaum/copilot.lua' },
        opts = {
            max_completions = 3, -- Maximum suggestions to show in menu
            max_attempts = 4,    -- Maximum API attempts before giving up
        },
    },
}
