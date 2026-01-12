return {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = {
        'rafamadriz/friendly-snippets',
        {
            'L3MON4D3/LuaSnip',
            version = 'v2.*',
            build = 'make install_jsregexp',
            config = function()
                local ls = require('luasnip')
                require('luasnip.loaders.from_vscode').lazy_load()

                -- ============================================================
                -- Load Custom Snippets
                -- ============================================================

                local snippets_path = vim.fn.stdpath('config') .. '/lua/yousef/snippets'

                if vim.fn.isdirectory(snippets_path) == 1 then
                    for _, file in ipairs(vim.fn.readdir(snippets_path)) do
                        if file:match('%.lua$') then
                            local ft = file:gsub('%.lua$', '')
                            local ok, snips = pcall(require, 'yousef.snippets.' .. ft)
                            if ok and snips then
                                ls.add_snippets(ft, snips)
                            end
                        end
                    end
                end

                -- ============================================================
                -- Snippet Navigation Keymaps
                -- ============================================================

                vim.keymap.set({ 'i', 's' }, '<C-l>', function()
                    if ls.expand_or_jumpable() then
                        ls.expand_or_jump()
                    end
                end, { silent = true, desc = 'Snippet expand or jump' })

                vim.keymap.set({ 'i', 's' }, '<C-h>', function()
                    if ls.jumpable(-1) then
                        ls.jump(-1)
                    end
                end, { silent = true, desc = 'Snippet jump back' })

                vim.keymap.set({ 'i', 's' }, '<C-j>', function()
                    if ls.choice_active() then
                        ls.change_choice(1)
                    end
                end, { silent = true, desc = 'Snippet next choice' })
            end,
        },
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {

        -- ====================================================================
        -- Keymap Configuration
        -- ====================================================================

        keymap = {
            preset = 'default',

            ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<C-e>'] = { 'hide', 'fallback' },
            ['<C-y>'] = { 'accept', 'fallback' },

            -- Smart tab behavior (If snippet active, accept; otherwise select next item)
            ['<Tab>'] = {
                function(cmp)
                    if cmp.snippet_active() then
                        return cmp.accept()
                    else
                        return cmp.select_next()
                    end
                end,
                'snippet_forward',
                'fallback',
            },

            -- Select previous item or jump backward in snippet
            ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },

            -- Navigate completion items
            ['<C-n>'] = { 'select_next', 'fallback' },
            ['<C-p>'] = { 'select_prev', 'fallback' },

            -- Scroll documentation
            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        },

        -- ====================================================================
        -- Appearance Settings
        -- ====================================================================

        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono',
        },

        -- ====================================================================
        -- Fuzzy Matching
        -- ====================================================================

        fuzzy = {
            implementation = 'lua',
        },

        -- ====================================================================
        -- Completion Sources
        -- ====================================================================

        cmdline = { enabled = false },

        sources = {
            -- Active sources in order of priority
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },

        -- ====================================================================
        -- Completion Behavior
        -- ====================================================================

        completion = {
            accept = {
                auto_brackets = { enabled = true },
            },

            documentation = {
                auto_show = true,         -- Show docs automatically
                auto_show_delay_ms = 200, -- Delay before showing (ms)
                window = {
                    border = 'rounded',   -- Rounded border for doc window
                },
            },

            -- Show preview of completion as ghost text
            ghost_text = {
                enabled = true,
            },

            -- Completion list behavior
            list = {
                selection = {
                    preselect = true,
                    auto_insert = true,
                },
            },

            menu = {
                border = 'rounded',

                -- How to render menu items
                draw = {
                    columns = {
                        { 'kind_icon' },                                -- Icon for completion kind
                        { 'label',      'label_description', gap = 1 }, -- Label with description
                        { 'source_name' },                              -- Source name
                    },

                    components = {
                        kind_icon = {
                            ellipsis = false,
                            text = function(ctx)
                                local kind_icons = {
                                    Text = ' ',
                                    Method = ' ',
                                    Function = ' ',
                                    Constructor = ' ',
                                    Field = ' ',
                                    Variable = ' ',
                                    Class = ' ',
                                    Interface = ' ',
                                    Module = ' ',
                                    Property = ' ',
                                    Unit = ' ',
                                    Value = ' ',
                                    Enum = ' ',
                                    Keyword = ' ',
                                    Snippet = ' ',
                                    Color = ' ',
                                    File = ' ',
                                    Reference = ' ',
                                    Folder = ' ',
                                    EnumMember = ' ',
                                    Constant = ' ',
                                    Struct = ' ',
                                    Event = ' ',
                                    Operator = ' ',
                                    TypeParameter = ' ',
                                }
                                return kind_icons[ctx.kind] or ctx.kind_icon
                            end,
                        },

                        -- Show source in brackets
                        source_name = {
                            width = { max = 30 },
                            text = function(ctx)
                                return '[' .. ctx.source_name .. ']'
                            end,
                            highlight = 'BlinkCmpSource',
                        },
                    },
                },
            },
        },

        -- ====================================================================
        -- Signature Help
        -- ====================================================================

        signature = {
            enabled = true,
            window = {
                border = 'rounded',
            },
        },

        -- ====================================================================
        -- Snippet Integration
        -- ====================================================================

        snippets = {
            expand = function(snippet)
                require('luasnip').lsp_expand(snippet)
            end,

            active = function(filter)
                if filter and filter.direction then
                    return require('luasnip').jumpable(filter.direction)
                end
                return require('luasnip').in_snippet()
            end,

            -- Jump within snippet
            jump = function(direction)
                require('luasnip').jump(direction)
            end,
        },
    },

    -- Keys to extend when merging opts
    opts_extend = { 'sources.default' },
}
