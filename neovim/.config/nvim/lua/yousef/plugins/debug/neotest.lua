return {
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-neotest/nvim-nio',
            'nvim-lua/plenary.nvim',
            'antoinemadec/FixCursorHold.nvim',
            'nvim-treesitter/nvim-treesitter',

            -- ================================================================
            -- Test Adapters (one per language/framework)
            -- ================================================================

            'nvim-neotest/neotest-python', -- Python (pytest, unittest)
            'nvim-neotest/neotest-jest',   -- JavaScript (Jest)
            'rouge8/neotest-rust',         -- Rust (cargo test)
            'Issafalcon/neotest-dotnet',   -- .NET (dotnet test)
            'olimorris/neotest-phpunit',   -- PHP (PHPUnit)
            'alfaix/neotest-gtest',        -- C++ (Google Test)
        },

        keys = {
            {
                '<leader>tt',
                function()
                    require('neotest').run.run()
                end,
                desc = 'Run Nearest Test',
            },
            {
                '<leader>tf',
                function()
                    require('neotest').run.run(vim.fn.expand('%'))
                end,
                desc = 'Run File Tests',
            },
            {
                '<leader>tT',
                function()
                    require('neotest').run.run(vim.uv.cwd())
                end,
                desc = 'Run All Tests',
            },
            {
                '<leader>tl',
                function()
                    require('neotest').run.run_last()
                end,
                desc = 'Run Last Test',
            },
            {
                '<leader>ts',
                function()
                    require('neotest').summary.toggle()
                end,
                desc = 'Toggle Summary',
            },
            {
                '<leader>to',
                function()
                    require('neotest').output.open({ enter = true, auto_close = true })
                end,
                desc = 'Show Output',
            },
            {
                '<leader>tO',
                function()
                    require('neotest').output_panel.toggle()
                end,
                desc = 'Toggle Output Panel',
            },
            {
                '<leader>tS',
                function()
                    require('neotest').run.stop()
                end,
                desc = 'Stop Test',
            },
            {
                '<leader>tw',
                function()
                    require('neotest').watch.toggle(vim.fn.expand('%'))
                end,
                desc = 'Toggle Watch',
            },
            {
                '<leader>td',
                function()
                    require('neotest').run.run({ strategy = 'dap' })
                end,
                desc = 'Debug Nearest Test',
            },
        },
        opts = function()
            return {
                -- ============================================================
                -- Test Adapters Configuration
                -- ============================================================

                adapters = {
                    -- Python adapter (pytest)
                    require('neotest-python')({
                        dap = { justMyCode = false }, -- Debug library code too
                        args = { '--log-level', 'DEBUG' },
                        runner = 'pytest',
                    }),

                    -- JavaScript adapter (Jest)
                    require('neotest-jest')({
                        jestCommand = 'npm test --',
                        jestConfigFile = 'jest.config.js',
                        env = { CI = true }, -- Run in CI mode
                        cwd = function()
                            return vim.fn.getcwd()
                        end,
                    }),

                    -- Rust adapter (cargo test)
                    require('neotest-rust')({
                        args = { '--no-capture' }, -- Show test output
                    }),

                    -- .NET adapter (dotnet test)
                    require('neotest-dotnet')({
                        dap = { justMyCode = false },
                    }),

                    -- PHP adapter (PHPUnit)
                    require('neotest-phpunit')({
                        phpunit_cmd = function()
                            return 'vendor/bin/phpunit'
                        end,
                    }),

                    -- C++ adapter (Google Test)
                    require('neotest-gtest').setup({}),
                },

                -- ============================================================
                -- Display Options
                -- ============================================================

                status = { virtual_text = true },
                output = { open_on_run = true },
                quickfix = {
                    open = function()
                        vim.cmd('copen')
                    end,
                },

                -- ============================================================
                -- Icons
                -- ============================================================

                -- icons = {
                --     failed = '', -- Test failed
                --     passed = '', -- Test passed
                --     running = '', -- Test running
                --     skipped = '', -- Test skipped
                --     unknown = '', -- Unknown state
                --     watching = '󰈈', -- Watch mode active
                -- },
                --
                -- ============================================================
                -- Floating Window
                -- ============================================================

                floating = {
                    border = 'rounded',
                    max_height = 0.6,
                    max_width = 0.6,
                },

                -- ============================================================
                -- Summary Panel
                -- ============================================================

                summary = {
                    animated = true,      -- Animate status changes
                    enabled = true,       -- Enable summary panel
                    expand_errors = true, -- Auto-expand failed tests
                    follow = true,        -- Follow cursor in source

                    mappings = {
                        attach = 'a',                         -- Attach to test process
                        clear_marked = 'M',                   -- Clear marked tests
                        clear_target = 'T',                   -- Clear target
                        debug = 'd',                          -- Debug test
                        debug_marked = 'D',                   -- Debug all marked
                        expand = { '<CR>', '<2-LeftMouse>' }, -- Expand/collapse
                        expand_all = 'e',                     -- Expand all
                        jumpto = 'i',                         -- Jump to test
                        mark = 'm',                           -- Mark test
                        next_failed = 'J',                    -- Next failed test
                        output = 'o',                         -- Show output
                        prev_failed = 'K',                    -- Previous failed test
                        run = 'r',                            -- Run test
                        run_marked = 'R',                     -- Run all marked
                        short = 'O',                          -- Short output
                        stop = 'u',                           -- Stop test
                        target = 't',                         -- Set target
                        watch = 'w',                          -- Toggle watch
                    },
                },
            }
        end,

        config = function(_, opts)
            require('neotest').setup(opts)
        end,
    },
}
