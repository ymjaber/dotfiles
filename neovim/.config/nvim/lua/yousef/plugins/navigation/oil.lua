return {
    'stevearc/oil.nvim',
    config = function()
        require('oil').setup({
            -- Replace netrw as the default file explorer
            default_file_explorer = true,

            keymaps = {
                ['<C-h>'] = false,
                ['<C-c>'] = false,
                ['<M-h>'] = { 'actions.select', opts = { horizontal = true } },
                ['<M-v>'] = { 'actions.select', opts = { vertical = true } },
                ['q'] = 'actions.close',
            },

            delete_to_trash = true,                 -- Use trash instead of permanent delete
            view_options = {
                show_hidden = true,                 -- Show hidden files by default
            },
            skip_confirm_for_simple_edits = true,   -- Skip confirmation for simple edits
        })

        vim.keymap.set('n', '<leader>-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
        vim.keymap.set('n', '-', require('oil').toggle_float)

        -- Auto-enable cursorline in Oil buffers
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'oil',
            callback = function()
                vim.opt_local.cursorline = true
            end,
        })
    end,
}
