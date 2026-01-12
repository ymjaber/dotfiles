return {
    'stevearc/aerial.nvim',
    event = 'LspAttach',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },

    keys = {
        { '<leader>cs', '<cmd>AerialToggle<cr>',    desc = 'Toggle Aerial (Symbols)' },
        { '<leader>cS', '<cmd>AerialNavToggle<cr>', desc = 'Aerial Navigation' },
        { '[s',         '<cmd>AerialPrev<cr>',      desc = 'Previous Symbol' },
        { ']s',         '<cmd>AerialNext<cr>',      desc = 'Next Symbol' },
    },

    opts = {

        -- ====================================================================
        -- Backend Configuration
        -- ====================================================================

        -- Priority list of symbol providers
        -- Tries each in order until one works
        backends = { 'lsp', 'treesitter', 'markdown', 'man' },

        -- ====================================================================
        -- Layout Configuration
        -- ====================================================================

        layout = {
            max_width = { 40, 0.2 }, -- 40 cols or 20% of screen
            min_width = 20,
            win_opts = {},
            default_direction = 'prefer_right',
            placement = 'window',
            resize_to_content = true,
            preserve_equality = false,
        },

        attach_mode = 'global',
        close_automatic_events = { 'unsupported' },

        -- ====================================================================
        -- Keymaps (inside Aerial window)
        -- ====================================================================

        keymaps = {
            -- Help
            ['?'] = 'actions.show_help',
            ['g?'] = 'actions.show_help',

            -- Navigation and jumping
            ['<CR>'] = 'actions.jump',             -- Jump to symbol
            ['<2-LeftMouse>'] = 'actions.jump',    -- Double-click to jump
            ['<C-v>'] = 'actions.jump_vsplit',     -- Open in vertical split
            ['<C-s>'] = 'actions.jump_split',      -- Open in horizontal split
            ['p'] = 'actions.scroll',              -- Scroll without leaving Aerial
            ['<C-j>'] = 'actions.down_and_scroll', -- Move down and scroll
            ['<C-k>'] = 'actions.up_and_scroll',   -- Move up and scroll

            -- Symbol navigation
            ['{'] = 'actions.prev',     -- Previous symbol at same level
            ['}'] = 'actions.next',     -- Next symbol at same level
            ['[['] = 'actions.prev_up', -- Previous symbol, go up a level
            [']]'] = 'actions.next_up', -- Next symbol, go up a level

            -- Window management
            ['q'] = 'actions.close', -- Close Aerial window

            -- Tree fold operations (vim-style)
            ['o'] = 'actions.tree_toggle',               -- Toggle fold
            ['za'] = 'actions.tree_toggle',              -- Toggle fold (vim)
            ['O'] = 'actions.tree_toggle_recursive',     -- Toggle fold recursively
            ['zA'] = 'actions.tree_toggle_recursive',
            ['l'] = 'actions.tree_open',                 -- Open fold
            ['zo'] = 'actions.tree_open',
            ['L'] = 'actions.tree_open_recursive',       -- Open fold recursively
            ['zO'] = 'actions.tree_open_recursive',
            ['h'] = 'actions.tree_close',                -- Close fold
            ['zc'] = 'actions.tree_close',
            ['H'] = 'actions.tree_close_recursive',      -- Close fold recursively
            ['zC'] = 'actions.tree_close_recursive',
            ['zr'] = 'actions.tree_increase_fold_level', -- Increase fold level
            ['zR'] = 'actions.tree_open_all',            -- Open all folds
            ['zm'] = 'actions.tree_decrease_fold_level', -- Decrease fold level
            ['zM'] = 'actions.tree_close_all',           -- Close all folds
            ['zx'] = 'actions.tree_sync_folds',          -- Sync folds with buffer
            ['zX'] = 'actions.tree_sync_folds',
        },

        -- ====================================================================
        -- Lazy Loading & Performance
        -- ====================================================================
        -- lazy_load: Load symbols lazily for performance
        lazy_load = true,

        -- disable_max_lines: Disable for files larger than this
        disable_max_lines = 10000,

        -- disable_max_size: Disable for files larger than 2MB
        disable_max_size = 2000000,

        -- ====================================================================
        -- Symbol Filtering
        -- ====================================================================
        -- filter_kind: Only show these symbol types
        filter_kind = {
            'Class',
            'Constructor',
            'Enum',
            'Function',
            'Interface',
            'Module',
            'Method',
            'Struct',
            'Constant',
            'Field',
            'Property',
        },

        -- ====================================================================
        -- Highlighting
        -- ====================================================================
        -- highlight_mode: How to highlight symbols
        highlight_mode = 'split_width',

        -- highlight_closest: Highlight symbol nearest to cursor
        highlight_closest = true,

        -- highlight_on_hover: Highlight when hovering in Aerial
        highlight_on_hover = false,

        -- highlight_on_jump: Flash duration when jumping (ms)
        highlight_on_jump = 300,

        -- autojump: Don't auto-jump when moving in Aerial
        autojump = false,

        -- icons: Use default icons (from nvim-web-devicons)
        icons = {},

        -- ====================================================================
        -- Buffer/Window Filtering
        -- ====================================================================
        ignore = {
            -- unlisted_buffers: Ignore unlisted buffers
            unlisted_buffers = true,

            -- filetypes: Specific filetypes to ignore
            filetypes = {},

            -- buftypes: Ignore special buffer types
            buftypes = 'special',

            -- wintypes: Ignore special window types
            wintypes = 'special',
        },

        -- ====================================================================
        -- Fold Integration
        -- ====================================================================
        -- manage_folds: Don't manage vim folds
        manage_folds = false,

        -- link_folds_to_tree: Don't sync vim folds to tree
        link_folds_to_tree = false,

        -- link_tree_to_folds: Sync tree state to vim folds
        link_tree_to_folds = true,

        -- nerd_font: Auto-detect nerd font availability
        nerd_font = 'auto',

        -- on_attach: Callback when Aerial attaches to buffer
        on_attach = function(_) end,

        -- open_automatic: Don't open automatically
        open_automatic = false,

        -- post_jump_cmd: Center screen after jumping
        post_jump_cmd = 'normal! zz',

        -- close_on_select: Don't close after selecting symbol
        close_on_select = false,

        -- update_events: Events that trigger symbol updates
        update_events = 'TextChanged,InsertLeave',

        -- ====================================================================
        -- Guide Lines
        -- ====================================================================
        -- show_guides: Show tree guide lines
        show_guides = true,

        -- guides: Characters for tree structure
        guides = {
            mid_item = '├─', -- Middle item in list
            last_item = '└─', -- Last item in list
            nested_top = '│ ', -- Vertical line for nesting
            whitespace = '  ', -- Spacing
        },

        -- ====================================================================
        -- Floating Window Configuration
        -- ====================================================================
        float = {
            -- border: Floating window border style
            border = 'rounded',

            -- relative: Position relative to cursor
            relative = 'cursor',

            -- max_height: Maximum height (90% of screen)
            max_height = 0.9,

            -- height: Auto height
            height = nil,

            -- min_height: Minimum height
            min_height = { 8, 0.1 },

            -- override: Custom position function
            override = function(conf, source_winid)
                conf.anchor = 'NE' -- Northeast anchor
                conf.col = vim.fn.winwidth(source_winid)
                conf.row = 0
                return conf
            end,
        },

        -- ====================================================================
        -- Navigation Window Configuration
        -- ====================================================================
        nav = {
            border = 'rounded',
            max_height = 0.9,
            min_height = { 10, 0.1 },
            max_width = 0.5,
            min_width = { 0.2, 20 },
            win_opts = {
                cursorline = true, -- Highlight current line
                winblend = 10,     -- Slight transparency
            },
            autojump = false,
            preview = false,
            keymaps = {
                ['<CR>'] = 'actions.jump',
                ['<2-LeftMouse>'] = 'actions.jump',
                ['<C-v>'] = 'actions.jump_vsplit',
                ['<C-s>'] = 'actions.jump_split',
                ['h'] = 'actions.left',
                ['l'] = 'actions.right',
                ['<C-c>'] = 'actions.close',
            },
        },

        -- ====================================================================
        -- Backend-Specific Configuration
        -- ====================================================================

        lsp = {
            diagnostics_trigger_update = true,
            update_when_errors = true,
            update_delay = 300,
        },

        treesitter = {
            update_delay = 300,
        },

        markdown = {
            update_delay = 300,
        },

        man = {
            update_delay = 300,
        },
    },
}
