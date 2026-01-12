return {
    -- ========================================================================
    -- PLUGIN: nvim-lspconfig - Core LSP Client
    -- ========================================================================
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            { 'j-hui/fidget.nvim', opts = {} },
        },

        config = function()
            -- ================================================================
            -- LSP Attach Callback
            -- ================================================================

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),

                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                    end

                    -- ========================================================
                    -- Navigation Keymaps
                    -- ========================================================

                    map('gd', vim.lsp.buf.definition, 'Go to Definition')
                    map('gD', vim.lsp.buf.declaration, 'Go to Declaration')
                    map('gr', vim.lsp.buf.references, 'Go to References')
                    map('gi', vim.lsp.buf.implementation, 'Go to Implementation')
                    map('gt', vim.lsp.buf.type_definition, 'Go to Type Definition')

                    -- ========================================================
                    -- Documentation Keymaps
                    -- ========================================================

                    map('K', vim.lsp.buf.hover, 'Hover Documentation')
                    map('<C-k>', vim.lsp.buf.signature_help, 'Signature Help')
                    vim.keymap.set({ 'n', 'i' }, '<C-j>', function() require('noice.lsp').signature() end, { buffer = event.buf, desc = 'LSP: Signature Documentation' })

                    -- ========================================================
                    -- Code Action Keymaps
                    -- ========================================================

                    map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')

                    map('<leader>cr', vim.lsp.buf.rename, 'Rename')

                    -- ========================================================
                    -- Workspace Keymaps
                    -- ========================================================

                    map('<leader>ws', vim.lsp.buf.workspace_symbol, 'Workspace Symbols')
                    map('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Add Workspace Folder')
                    map('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Remove Workspace Folder')

                    -- ========================================================
                    -- Inlay Hints (Neovim 0.10+)
                    -- ========================================================

                    local client = vim.lsp.get_client_by_id(event.data.client_id)

                    if client and client.supports_method('textDocument/inlayHint') then
                        map('<leader>th', function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                        end, 'Toggle Inlay Hints')
                    end

                    -- ========================================================
                    -- Document Highlight
                    -- ========================================================

                    if client and client.supports_method('textDocument/documentHighlight') then
                        local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

                        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })

                        vim.api.nvim_create_autocmd('LspDetach', {
                            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = event2.buf })
                            end,
                        })
                    end
                end,
            })

            -- ================================================================
            -- Diagnostic Configuration
            -- ================================================================

            vim.diagnostic.config({
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 4,            -- Space before virtual text
                    source = 'if_many',     -- Show source if multiple diagnostics
                    prefix = '●',           -- Prefix character
                },

                severity_sort = true,

                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = ' ',  -- Error icon
                        [vim.diagnostic.severity.WARN] = ' ',   -- Warning icon
                        [vim.diagnostic.severity.HINT] = '󰠠 ',  -- Hint icon
                        [vim.diagnostic.severity.INFO] = ' ',   -- Info icon
                    },
                },

                float = {
                    border = 'rounded',  -- Rounded border
                    source = true,       -- Show which LSP produced this
                },
            })

            -- ================================================================
            -- LSP Server Configurations
            -- ================================================================

            local servers = {
                -- ==================================================
                -- Lua Language Server
                -- ==================================================
                lua_ls = {
                    settings = {
                        Lua = {
                            workspace = { checkThirdParty = false },
                            codeLens = { enable = true },
                            completion = { callSnippet = 'Replace' },
                            diagnostics = { globals = { 'vim' } },
                            hint = { enable = true },
                        },
                    },
                },

                -- ==================================================
                -- TypeScript/JavaScript Language Server
                -- ==================================================
                ts_ls = {
                    settings = {
                        typescript = {
                            inlayHints = {
                                includeInlayParameterNameHints = 'all',
                                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = true,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                            },
                        },
                        javascript = {
                            inlayHints = {
                                includeInlayParameterNameHints = 'all',
                                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = true,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                            },
                        },
                    },
                },

                -- ==================================================
                -- Python - BasedPyright (faster Pyright fork)
                -- ==================================================
                basedpyright = {
                    settings = {
                        basedpyright = {
                            analysis = {
                                typeCheckingMode = 'basic',
                                autoImportCompletions = true,
                            },
                        },
                    },
                },

                -- ==================================================
                -- C/C++ - Clangd
                -- ==================================================
                clangd = {
                    cmd = {
                        'clangd',
                        '--background-index',         -- Index in background
                        '--clang-tidy',               -- Enable clang-tidy checks
                        '--header-insertion=iwyu',    -- Include What You Use
                        '--completion-style=detailed', -- Detailed completions
                        '--function-arg-placeholders', -- Add placeholders for args
                        '--fallback-style=llvm',      -- Default formatting style
                    },
                    init_options = {
                        usePlaceholders = true,       -- Use placeholders in snippets
                        completeUnimported = true,    -- Complete symbols not imported
                        clangdFileStatus = true,      -- Show file parsing status
                    },
                },

                -- ==================================================
                -- Web Development Servers
                -- ==================================================
                html = {},                    -- HTML language server
                cssls = {},                   -- CSS language server
                tailwindcss = {},             -- Tailwind CSS intellisense
                emmet_language_server = {},   -- Emmet abbreviations

                -- ==================================================
                -- Data Format Servers
                -- ==================================================
                jsonls = {
                    settings = {
                        json = {
                            validate = { enable = true },
                        },
                    },
                },
                yamlls = {
                    settings = {
                        yaml = {
                            keyOrdering = false,
                        },
                    },
                },

                -- ==================================================
                -- DevOps Servers
                -- ==================================================
                dockerls = {},                        -- Dockerfile
                docker_compose_language_service = {}, -- docker-compose.yml

                -- ==================================================
                -- Shell Script
                -- ==================================================
                bashls = {},  -- Bash language server
            }

            -- ================================================================
            -- Setup Completion Capabilities
            -- ================================================================

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

            -- ================================================================
            -- Setup Mason-LSPconfig
            -- ================================================================

            require('mason-lspconfig').setup({
                ensure_installed = vim.tbl_keys(servers),

                handlers = {
                    function(server_name)
                        -- Get server config or empty table
                        local server = servers[server_name] or {}
                        -- Merge capabilities
                        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                        -- Setup the server
                        require('lspconfig')[server_name].setup(server)
                    end,
                },
            })
        end,
    },

    -- ========================================================================
    -- PLUGIN: Mason - LSP/DAP/Linter/Formatter Package Manager
    -- ========================================================================
    {
        'williamboman/mason.nvim',
        cmd = 'Mason',
        build = ':MasonUpdate',
        opts = {
            ui = {
                border = 'rounded',
                icons = {
                    package_installed = '✓',    -- Installed successfully
                    package_pending = '➜',      -- Installation in progress
                    package_uninstalled = '✗',  -- Not installed
                },
            },
        },
    },

    -- ========================================================================
    -- PLUGIN: Mason-LSPconfig - Bridge between Mason and LSPconfig
    -- ========================================================================
    {
        'williamboman/mason-lspconfig.nvim',
        opts = {},
    },
}
