-- NOTE: Run :MasonInstall roslyn netcoredbg after setup
return {
    -- ========================================================================
    -- PLUGIN 1: roslyn.nvim - C# Language Server
    -- ========================================================================
    {
        'seblyng/roslyn.nvim',
        ft = { 'cs', 'razor' },
        dependencies = {
            'williamboman/mason.nvim',
        },

        opts = {
            filewatching = true, -- Watch files for changes
            choose_target = nil, -- Function to choose startup project (nil = auto)
            ignore_target = nil, -- Function to filter out targets (nil = none)
            lock_target = false, -- Lock to first selected target
        },

        config = function(_, opts)
            require('mason').setup({
                registries = {

                    'github:Crashdummyy/mason-registry', -- Community registry with roslyn (provides the roslyn package)
                    'github:mason-org/mason-registry',   -- Official mason registry
                },
            })

            require('roslyn').setup(opts)
        end,
    },

    -- ========================================================================
    -- PLUGIN 2: Ionide-vim - F# Support
    -- ========================================================================
    {
        'ionide/Ionide-vim',
        ft = { 'fsharp', 'fs', 'fsx', 'fsi' },
    },

    -- ========================================================================
    -- PLUGIN 3: easy-dotnet.nvim - .NET Development Toolkit
    -- ========================================================================
    {
        'GustavEikaas/easy-dotnet.nvim',
        ft = { 'cs', 'fsharp', 'vb', 'csproj', 'fsproj', 'sln', 'slnx' },
        dependencies = {
            'nvim-lua/plenary.nvim',
            'ibhagwan/fzf-lua',
        },

        keys = {
            -- ==================================================
            -- Project Management
            -- ==================================================

            { '<leader>dr',  function() require('easy-dotnet').run() end,                 desc = 'Run project' },
            { '<leader>dR',  function() require('easy-dotnet').restore() end,             desc = 'Restore packages' },
            { '<leader>db',  function() require('easy-dotnet').build() end,               desc = 'Build project/solution' },
            { '<leader>dc',  function() require('easy-dotnet').clean() end,               desc = 'Clean project' },

            -- ==================================================
            -- Testing
            -- ==================================================

            { '<leader>dt',  function() require('easy-dotnet').test() end,                desc = 'Run tests' },
            { '<leader>dT',  function() require('easy-dotnet').test_solution() end,       desc = 'Run all tests' },

            -- ==================================================
            -- NuGet Package Management
            -- ==================================================

            { '<leader>dp',  function() require('easy-dotnet').add_package() end,         desc = 'Add NuGet package' },
            { '<leader>dP',  function() require('easy-dotnet').remove_package() end,      desc = 'Remove NuGet package' },

            -- ==================================================
            -- Project Creation
            -- ==================================================

            { '<leader>dn',  function() require('easy-dotnet').new() end,                 desc = 'New project/item' },

            -- ==================================================
            -- Miscellaneous
            -- ==================================================

            { '<leader>ds',  function() require('easy-dotnet').secrets() end,             desc = 'User secrets' },
            { '<leader>do',  function() require('easy-dotnet').outdated() end,            desc = 'Outdated packages' },

            -- ==================================================
            -- Entity Framework Core
            -- ==================================================

            { '<leader>dea', function() require('easy-dotnet').ef_add_migration() end,    desc = 'EF add migration' },
            { '<leader>deu', function() require('easy-dotnet').ef_update_database() end,  desc = 'EF update database' },
            { '<leader>der', function() require('easy-dotnet').ef_remove_migration() end, desc = 'EF remove migration' },

            -- ==================================================
            -- Test Runner (Rider-like)
            -- ==================================================

            { '<leader>dtr', function() require('easy-dotnet').testrunner() end,         desc = 'Open test runner' },
        },

        opts = {
            lsp = {
                enabled = false
            },
            picker = 'fzf',

            -- Auto-generate namespace for new files
            auto_bootstrap_namespace = {
                -- Automatically add namespace when creating .cs files
                enabled = true,

                -- Namespace style
                type = 'file_scoped',

                -- Convert JSON from clipboard to C# class
                use_clipboard_json = {
                    -- behavior: 'auto' | 'prompt' | 'never'
                    behavior = 'prompt',
                    register = '+',
                },
            },

            -- Project creation settings
            new = {
            },

            -- Test runner configuration (Rider-like experience)
            test_runner = {
                -- Run tests from buffer
                enable_buffer_test_execution = true,

                -- 'float' | 'split' | 'vsplit' | 'buf'
                viewmode = 'float',

                -- Test result icons
                icons = {
                    passed = '',  -- Green checkmark
                    failed = '',  -- Red X
                    skipped = '', -- Yellow skip
                    running = '', -- Spinning
                },

                -- Keymaps in test runner window
                mappings = {
                    run = 'r',             -- Run test
                    debug = 'd',           -- Debug test
                    expand = 'o',          -- Expand/collapse
                    peek_stacktrace = 'p', -- View stack trace
                    filter = 'f',          -- Filter tests
                },
            },

            -- Enable project file features
            csproj_mappings = true,
            fsproj_mappings = true,

            -- Terminal configuration for running projects
            terminal = function(path, action, args)
                args = args or ''

                local cmd_by_action = {
                    run     = function() return string.format('dotnet run --project %s %s', vim.fn.shellescape(path), args) end,
                    test    = function() return string.format('dotnet test %s %s', vim.fn.shellescape(path), args) end,
                    restore = function() return string.format('dotnet restore %s %s', vim.fn.shellescape(path), args) end,
                    build   = function() return string.format('dotnet build %s %s', vim.fn.shellescape(path), args) end,
                    watch   = function() return string.format('dotnet watch --project %s %s', vim.fn.shellescape(path), args) end,
                }

                local command = cmd_by_action[action] and cmd_by_action[action]() or nil
                if not command then
                    vim.notify('easy-dotnet: unknown action: ' .. tostring(action), vim.log.levels.ERROR)
                    return
                end

                if require('easy-dotnet.extensions').isWindows() == true then
                    command = command .. "\r"
                end

                -- Floating terminal
                local buf = vim.api.nvim_create_buf(false, true)
                local width  = math.floor(vim.o.columns * 0.8)
                local height = math.floor(vim.o.lines * 0.8)
                local row = math.floor((vim.o.lines - height) / 2)
                local col = math.floor((vim.o.columns - width) / 2)

                vim.api.nvim_open_win(buf, true, {
                    relative = 'editor',
                    width = width,
                    height = height,
                    row = row,
                    col = col,
                    style = 'minimal',
                    border = 'rounded',
                })

                vim.fn.termopen(command)
                vim.cmd('startinsert')
            end,


            -- Debug Adapter Protocol configuration
            dap = {
                auto_generate = true, -- Auto-create DAP configuration
            },
        },

        config = function(_, opts)
            require('easy-dotnet').setup(opts)
        end,
    },
}
