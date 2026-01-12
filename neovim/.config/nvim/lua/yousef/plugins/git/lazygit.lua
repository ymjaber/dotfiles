return {
    'kdheepak/lazygit.nvim',

    cmd = {
        'LazyGit',                  -- Open LazyGit
        'LazyGitConfig',            -- Edit LazyGit config
        'LazyGitCurrentFile',       -- LazyGit for current file
        'LazyGitFilter',            -- LazyGit with filter
        'LazyGitFilterCurrentFile', -- Same as CurrentFile
    },

    dependencies = {
        'nvim-lua/plenary.nvim',
    },

    keys = {
        { '<leader>gg', '<cmd>LazyGit<cr>',            desc = 'LazyGit' },
        { '<leader>gG', '<cmd>LazyGitCurrentFile<cr>', desc = 'LazyGit Current File' },
    },

    config = function()
        vim.g.lazygit_floating_window_scaling_factor = 0.9 -- Size of floating window (0.9 = 90% of screen size)

        vim.g.lazygit_floating_window_border_chars = {
            '╭',
            '─',
            '╮',
            '│',
            '╯',
            '─',
            '╰',
            '│',
        }
    end,
}
