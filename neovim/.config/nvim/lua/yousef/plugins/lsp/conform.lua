return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
        {
            '<leader>cf',
            function()
                require('conform').format({
                    async = true,        -- Don't block while formatting
                    lsp_fallback = true, -- Use LSP if no formatter configured
                })
            end,
            desc = 'Format buffer',
        },

        -- Toggle autoformat on/off
        {
            '<leader>uf',
            function()
                vim.g.autoformat = not vim.g.autoformat
                vim.notify('Autoformat ' .. (vim.g.autoformat and 'enabled' or 'disabled'))
            end,
            desc = 'Toggle autoformat',
        },
    },

    opts = {
        -- ====================================================================
        -- Formatters by Filetype
        -- ====================================================================

        formatters_by_ft = {
            -- ==================================================
            -- Lua
            -- ==================================================

            lua = { 'stylua' },

            -- ==================================================
            -- JavaScript/TypeScript
            -- ==================================================

            javascript = { 'prettierd', 'prettier', stop_after_first = true },
            typescript = { 'prettierd', 'prettier', stop_after_first = true },
            javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
            typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },

            -- ==================================================
            -- Web Technologies
            -- ==================================================

            html = { 'prettierd', 'prettier', stop_after_first = true },
            css = { 'prettierd', 'prettier', stop_after_first = true },
            scss = { 'prettierd', 'prettier', stop_after_first = true },

            -- ==================================================
            -- Data Formats
            -- ==================================================

            json = { 'prettierd', 'prettier', stop_after_first = true },
            jsonc = { 'prettierd', 'prettier', stop_after_first = true }, -- JSON with comments
            yaml = { 'prettierd', 'prettier', stop_after_first = true },
            markdown = { 'prettierd', 'prettier', stop_after_first = true },

            -- ==================================================
            -- Python
            -- ==================================================

            python = { 'ruff_format', 'ruff_organize_imports' },

            -- ==================================================
            -- Rust
            -- ==================================================

            rust = { 'rustfmt' },

            -- ==================================================
            -- C/C++
            -- ==================================================

            c = { 'clang-format' },
            cpp = { 'clang-format' },

            -- ==================================================
            -- C#
            -- ==================================================

            cs = { 'csharpier' },

            -- ==================================================
            -- PHP
            -- ==================================================

            php = { 'pint', 'php_cs_fixer', stop_after_first = true },

            -- ==================================================
            -- Shell Scripts
            -- ==================================================

            sh = { 'shfmt' },
            bash = { 'shfmt' },

            -- ==================================================
            -- Go
            -- ==================================================

            go = { 'gofmt', 'goimports' },

            -- ==================================================
            -- SQL
            -- ==================================================

            sql = { 'sql_formatter' },
        },

        -- ====================================================================
        -- Default Format Options
        -- ====================================================================

        default_format_opts = {
            lsp_format = 'fallback',
        },

        -- ====================================================================
        -- Format on Save
        -- ====================================================================

        format_on_save = function(bufnr)
            if vim.g.autoformat == false then
                return
            end

            -- Skip formatting for very large files (performance)
            local lines = vim.api.nvim_buf_line_count(bufnr)
            if lines > 10000 then
                return -- Don't format files with more than 10k lines
            end

            -- Return format options
            return {
                timeout_ms = 3000,   -- Wait up to 3 seconds for formatting
                lsp_fallback = true, -- Use LSP if no formatter
            }
        end,

        -- ====================================================================
        -- Formatter-Specific Options
        -- ====================================================================

        formatters = {
            -- Configure shfmt to use 4-space indentation
            shfmt = {
                prepend_args = { '-i', '4' },
            },
        },
    },

    init = function()
        vim.g.autoformat = true
    end,
}
