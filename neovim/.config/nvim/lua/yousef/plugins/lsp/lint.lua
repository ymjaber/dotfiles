return {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local lint = require('lint')

        -- ====================================================================
        -- Linters by Filetype
        -- ====================================================================

        lint.linters_by_ft = {
            --
            -- ==================================================
            -- JavaScript/TypeScript
            -- ==================================================

            javascript = { 'eslint_d' },
            typescript = { 'eslint_d' },
            javascriptreact = { 'eslint_d' },
            typescriptreact = { 'eslint_d' },

            -- ==================================================
            -- Python
            -- ==================================================

            python = { 'ruff', 'mypy' },

            -- ==================================================
            -- Markdown
            -- ==================================================

            markdown = { 'markdownlint' }, -- NOTE: install markdown cli `npm install -g markdownlint-cli` or `pacman -S markdownlint-cli`

            -- ==================================================
            -- Shell Scripts
            -- ==================================================

            sh = { 'shellcheck' },
            bash = { 'shellcheck' },
        }

        -- ====================================================================
        -- Auto-Trigger Linting
        -- ====================================================================

        local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })

        -- ====================================================================
        -- Manual Lint Keymap
        -- ====================================================================

        vim.keymap.set('n', '<leader>cl', function()
            lint.try_lint()
        end, { desc = 'Trigger linting' })
    end,
}
