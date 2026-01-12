return {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',

    dependencies = {
        'saghen/blink.cmp', -- For inserting pairs on confirm
    },

    config = function()
        local autopairs = require('nvim-autopairs')

        autopairs.setup({
            -- Use treesitter for smarter pairing
            -- Won't auto-pair inside strings, comments, etc.
            check_ts = true,

            -- Treesitter node types where pairing is disabled
            ts_config = {
                lua = { 'string', 'source' },
                javascript = { 'string', 'template_string' },
                java = false,
            },

            disable_filetype = {
                'TelescopePrompt',
                'fzf',
                'spectre_panel',
            },

            fast_wrap = {
                map = '<M-e>',
                chars = { '{', '[', '(', '"', "'" },
                pattern = [=[[%'%"%>%]%)%}%,]]=],
                end_key = '$',
                before_key = 'h',
                after_key = 'l',
                cursor_pos_before = true,
                keys = 'qwertyuiopzxcvbnmasdfghjkl',
                check_comma = true,
                highlight = 'Search',
                highlight_grey = 'Comment',
            },
        })
    end,
}

