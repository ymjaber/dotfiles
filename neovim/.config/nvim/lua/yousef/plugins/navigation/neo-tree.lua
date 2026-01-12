return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x', -- Use stable v3 branch
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
        { '3rd/image.nvim', opts = {} },
    },
    lazy = false,
    cmd = 'Neotree',
    keys = {
        {
            '<leader>ee',
            ':Neotree reveal<CR>',
            desc = 'Reveal neo-tree'
        },
        {
            '<leader>ex',
            ':Neotree close<CR>',
            desc = 'Close neo-tree'
        },
        {
            '<leader>eg',
            function()
                require('neo-tree.command').execute({
                    source = 'git_status',
                    action = 'focus'
                })
            end,
            desc = 'Git explorer'
        },
        {
            '<leader>eb',
            function()
                require('neo-tree.command').execute({
                    source = 'buffers',
                    action = 'focus'
                })
            end,
            desc = 'Buffer explorer',
        },
    },
    opts = {
        window = {
            position = 'left',
            width = 30,
        },
        filesystem = {
            filtered_items = {
                hide_dotfiles = false,
                hide_gitignored = false,
            },
        },
        mappings = {
            ['<space>'] = 'toggle_node',
            ['<cr>'] = 'open',
            ['<esc>'] = 'cancel',
            ['P'] = {
                "toggle_preview",
                config = {
                    use_float = true,
                    use_image_nvim = true,
                },
            },
        },
    },
}
