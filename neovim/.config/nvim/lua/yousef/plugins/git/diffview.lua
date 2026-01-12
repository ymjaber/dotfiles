return {
    'sindrets/diffview.nvim',

    cmd = {
        'DiffviewOpen',
        'DiffviewClose',
        'DiffviewToggleFiles',
        'DiffviewFocusFiles',
        'DiffviewFileHistory', -- Open file history
    },

    keys = {
        { '<leader>gd', '<cmd>DiffviewOpen<cr>',          desc = 'Diff View' },
        { '<leader>gD', '<cmd>DiffviewOpen HEAD~1<cr>',   desc = 'Diff View (last commit)' },
        { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'File History' },
        { '<leader>gH', '<cmd>DiffviewFileHistory<cr>',   desc = 'Branch History' },
        { '<leader>gq', '<cmd>DiffviewClose<cr>',         desc = 'Close Diff View' },
    },

    opts = {
        -- Don't try to diff binary files
        diff_binaries = false,

        -- Use enhanced diff highlighting (Shows word-level changes within lines)
        enhanced_diff_hl = true,

        -- Show file type icons (requires nvim-web-devicons)
        use_icons = true,

        -- Show help hints in panels
        show_help_hints = true,

        -- ====================================================================
        -- View Layout Configuration
        -- ====================================================================

        view = {
            -- Layout for regular diff view
            default = {
                -- Side-by-side with split below
                layout = 'diff2_horizontal',
            },

            -- Layout for merge conflict resolution
            merge_tool = {
                -- 3-way diff with base in middle
                layout = 'diff3_mixed',

                -- Turn off LSP in merge view
                disable_diagnostics = true,
            },

            -- Layout for file history view
            file_history = {
                layout = 'diff2_horizontal',
            },
        },

        -- ====================================================================
        -- File Panel Configuration
        -- ====================================================================

        file_panel = {
            -- 'tree' = directory tree, 'list' = flat list
            listing_style = 'tree',

            -- Options for tree-style listing
            tree_options = {
                flatten_dirs = true, -- Collapse single-child directories

                -- When to show folder status
                -- "only_folded" = only for collapsed folders
                folder_statuses = 'only_folded',
            },

            -- Window configuration for file panel
            win_config = {
                position = 'left',
                width = 35,
            },
        },

        -- ====================================================================
        -- File History Panel Configuration
        -- ====================================================================

        file_history_panel = {
            log_options = {
                git = {
                    -- Options when viewing single file history
                    single_file = {
                        -- How to show merge commit diffs
                        diff_merges = 'combined',
                    },

                    -- Options when viewing branch history
                    multi_file = {
                        -- Follow first parent only (cleaner)
                        diff_merges = 'first-parent',
                    },
                },
            },

            -- Window configuration for history panel
            win_config = {
                position = 'bottom', -- Panel at bottom
                height = 16,         -- Height in lines
            },
        },

        hooks = {},
    },
}
