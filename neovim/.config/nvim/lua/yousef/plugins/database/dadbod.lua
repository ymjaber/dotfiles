return {
    -- ========================================================================
    -- PLUGIN: vim-dadbod - Core Database Interface
    -- ========================================================================
    {
        'tpope/vim-dadbod',
        cmd = { 'DB', 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },
    },

    -- ========================================================================
    -- PLUGIN: vim-dadbod-ui - Database UI Sidebar
    -- ========================================================================
    {
        'kristijanhusak/vim-dadbod-ui',
        cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },
        dependencies = {
            'tpope/vim-dadbod',
        },
        keys = {
            { '<leader>Du', '<cmd>DBUIToggle<cr>',        desc = 'Toggle Database UI' },
            { '<leader>Da', '<cmd>DBUIAddConnection<cr>', desc = 'Add DB Connection' },
            { '<leader>Df', '<cmd>DBUIFindBuffer<cr>',    desc = 'Find DB Buffer' },
        },

        init = function()
            -- ================================================================
            -- UI Display Options
            -- ================================================================

            vim.g.db_ui_use_nerd_fonts = 1
            vim.g.db_ui_show_database_icon = 1
            vim.g.db_ui_force_echo_notifications = 1
            vim.g.db_ui_win_position = "left"
            vim.g.db_ui_winwidth = 40

            -- ================================================================
            -- Table Helper Queries
            -- ================================================================

            vim.g.db_ui_table_helpers = {
                postgresql = {
                    Count = 'SELECT COUNT(*) FROM {table}',
                    List = 'SELECT * FROM {table} LIMIT 100',
                },
                sqlserver = {
                    Count = 'SELECT COUNT(*) FROM {table}',
                    List = 'SELECT TOP 100 * FROM {table}',
                },
            }

            -- ================================================================
            -- UI Icons
            -- ================================================================

            vim.g.db_ui_icons = {
                expanded = {
                    db = '▾ ',
                    buffers = '▾ ',
                    saved_queries = '▾ ',
                    schemas = '▾ ',
                    schema = '▾ ',
                    tables = '▾ ',
                    table = '▾ ',
                },
                collapsed = {
                    db = '▸ ',
                    buffers = '▸ ',
                    saved_queries = '▸ ',
                    schemas = '▸ ',
                    schema = '▸ ',
                    tables = '▸ ',
                    table = '▸ ',
                },
                saved_query = '', -- Saved query file
                new_query = '󰓰', -- New query action
                tables = '󰓫', -- Tables folder
                buffers = '', -- Buffers folder
                add_connection = '󰆺', -- Add connection action
                connection_ok = '✓', -- Connection successful
                connection_error = '✕', -- Connection failed
            }
        end,
    },

    -- ========================================================================
    -- PLUGIN: vim-dadbod-completion - SQL Autocompletion
    -- ========================================================================
    {
        'kristijanhusak/vim-dadbod-completion',
        ft = { 'sql', 'mysql', 'plsql' },
        dependencies = {
            'tpope/vim-dadbod',
        },
        init = function()
            vim.api.nvim_create_autocmd('FileType', {
                pattern = { 'sql', 'mysql', 'plsql' },
                callback = function()
                    vim.bo.omnifunc = 'vim_dadbod_completion#omni'
                end,
            })
        end,
    },
}
