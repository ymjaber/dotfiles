return {
    -- ========================================================================
    -- PLUGIN: nvim-dap - Core DAP Client
    -- ========================================================================
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            -- ================================================================
            -- Virtual Text - Show Variable Values Inline
            -- ================================================================
            {
                'theHamsta/nvim-dap-virtual-text',
                opts = {
                    enabled = true,
                    enabled_commands = true,
                    highlight_changed_variables = true,
                    highlight_new_as_changed = false,
                    show_stop_reason = true,
                    commented = false,
                    virt_text_pos = 'eol',
                },
            },

            -- ================================================================
            -- Mason DAP Integration - Auto-install Debuggers
            -- ================================================================
            {
                'jay-babu/mason-nvim-dap.nvim',
                dependencies = 'mason.nvim',
                cmd = { 'DapInstall', 'DapUninstall' },
                opts = {
                    automatic_installation = true,
                    handlers = {},
                    ensure_installed = {
                        'codelldb',          -- C/C++/Rust debugger
                        'netcoredbg',        -- .NET Core debugger
                        'debugpy',           -- Python debugger
                        'js-debug-adapter',  -- JavaScript/TypeScript
                        'php-debug-adapter', -- PHP debugger
                    },
                },
            },
        },

        keys = {
            {
                '<leader>dB',
                function()
                    require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
                end,
                desc = 'Breakpoint Condition',
            },

            { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle Breakpoint' },
            { '<leader>dc', function() require('dap').continue() end,          desc = 'Continue' },
            { '<leader>dC', function() require('dap').run_to_cursor() end,     desc = 'Run to Cursor' },
            { '<leader>dg', function() require('dap').goto_() end,             desc = 'Go to Line (No Execute)' },
            { '<leader>di', function() require('dap').step_into() end,         desc = 'Step Into' },
            { '<leader>dj', function() require('dap').down() end,              desc = 'Down' },
            { '<leader>dk', function() require('dap').up() end,                desc = 'Up' },
            { '<leader>dl', function() require('dap').run_last() end,          desc = 'Run Last' },
            { '<leader>do', function() require('dap').step_out() end,          desc = 'Step Out' },
            { '<leader>dO', function() require('dap').step_over() end,         desc = 'Step Over' },
            { '<leader>dp', function() require('dap').pause() end,             desc = 'Pause' },
            { '<leader>dr', function() require('dap').repl.toggle() end,       desc = 'Toggle REPL' },
            { '<leader>ds', function() require('dap').session() end,           desc = 'Session' },
            { '<leader>dt', function() require('dap').terminate() end,         desc = 'Terminate' },
            { '<leader>dw', function() require('dap.ui.widgets').hover() end,  desc = 'Widgets' },
        },

        config = function()
            -- ================================================================
            -- Sign Column Icons
            -- ================================================================

            vim.fn.sign_define('DapBreakpoint', {
                text = '', -- Red circle
                texthl = 'DiagnosticError',
                linehl = '',
                numhl = '',
            })

            vim.fn.sign_define('DapBreakpointCondition', {
                text = '', -- Yellow question mark
                texthl = 'DiagnosticWarn',
                linehl = '',
                numhl = '',
            })

            vim.fn.sign_define('DapLogPoint', {
                text = '', -- Blue info icon
                texthl = 'DiagnosticInfo',
                linehl = '',
                numhl = '',
            })

            vim.fn.sign_define('DapStopped', {
                text = '',                 -- Green arrow
                texthl = 'DiagnosticOk',
                linehl = 'DapStoppedLine', -- Highlight entire line
                numhl = '',
            })

            vim.fn.sign_define('DapBreakpointRejected', {
                text = '', -- Red X
                texthl = 'DiagnosticError',
                linehl = '',
                numhl = '',
            })

            vim.api.nvim_set_hl(0, 'DapStoppedLine', { bg = '#2d3f2d' })
        end,
    },

    -- ========================================================================
    -- PLUGIN: nvim-dap-ui - Debug UI Panels
    -- ========================================================================
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-neotest/nvim-nio', -- Async IO library
        },
        keys = {
            { '<leader>du', function() require('dapui').toggle({}) end, desc = 'DAP UI' },
            { '<leader>de', function() require('dapui').eval() end,     desc = 'Eval',  mode = { 'n', 'v' } },
        },
        opts = {
            icons = {
                expanded = '▾',
                collapsed = '▸',
                current_frame = '▸',
            },
            mappings = {
                expand = { '<CR>', '<2-LeftMouse>' }, -- Expand item
                open = 'o',                           -- Open item
                remove = 'd',                         -- Remove item
                edit = 'e',                           -- Edit value
                repl = 'r',                           -- Send to REPL
                toggle = 't',                         -- Toggle item
            },
            element_mappings = {},
            expand_lines = true,
            force_buffers = true,
            floating = {
                border = 'rounded',
                mappings = { close = { 'q', '<Esc>' } },
            },

            -- ================================================================
            -- Layout Configuration
            -- ================================================================

            layouts = {
                {
                    elements = {
                        { id = 'scopes',      size = 0.25 }, -- Variables
                        { id = 'breakpoints', size = 0.25 }, -- Breakpoints
                        { id = 'stacks',      size = 0.25 }, -- Call stack
                        { id = 'watches',     size = 0.25 }, -- Watch expressions
                    },
                    position = 'left',
                    size = 40,
                },
                {
                    elements = {
                        { id = 'repl',    size = 0.5 }, -- Debug REPL
                        { id = 'console', size = 0.5 }, -- Debug output
                    },
                    position = 'bottom',
                    size = 10,
                },
            },
            controls = {
                enabled = true,
                element = 'repl', -- Show controls in REPL
                icons = {
                    pause = '',
                    play = '',
                    step_into = '',
                    step_over = '',
                    step_out = '',
                    step_back = '',
                    run_last = '',
                    terminate = '',
                },
            },
            render = {
                indent = 1,
                max_value_lines = 100,
            },
        },
        config = function(_, opts)
            local dap = require('dap')
            local dapui = require('dapui')
            dapui.setup(opts)

            -- ================================================================
            -- Auto Open/Close UI
            -- ================================================================

            dap.listeners.after.event_initialized['dapui_config'] = function()
                dapui.open({})
            end

            dap.listeners.before.event_terminated['dapui_config'] = function()
                dapui.close({})
            end

            dap.listeners.before.event_exited['dapui_config'] = function()
                dapui.close({})
            end
        end,
    },
}
