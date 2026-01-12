return {
    'kylechui/nvim-surround',
    event = { 'BufReadPre', 'BufNewFile' },
    version = '*',
    config = function()
        require("nvim-surround").setup({
            keymaps = {
                visual = 'gs',
                visual_line = 'gS',
            },
        })

    end,
}

