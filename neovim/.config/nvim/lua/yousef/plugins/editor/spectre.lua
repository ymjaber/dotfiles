return {
    'nvim-pack/nvim-spectre',
    cmd = 'Spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        {
            '<leader>sr',
            function()
                require('spectre').toggle()
            end,
            desc = 'Search and Replace',
        },
        {
            '<leader>sw',
            function()
                require('spectre').open_visual({ select_word = true })
            end,
            desc = 'Search Current Word',
        },
        {
            '<leader>sw',
            function()
                require('spectre').open_visual()
            end,
            mode = 'v',
            desc = 'Search Selection',
        },
        {
            '<leader>sp',
            function()
                require('spectre').open_file_search({ select_word = true })
            end,
            desc = 'Search in Current File',
        },
    },
}
