return {
    'ibhagwan/fzf-lua',
    dependencies = { 'echasnovski/mini.icons' },
    config = function(_, opts)
        local fzf = require('fzf-lua')
        fzf.setup(opts)
        fzf.register_ui_select()
    end,
    opts = {

        keymap = {
            builtin = {
                ['<C-d>'] = 'preview-page-down',
                ['<C-u>'] = 'preview-page-up',
            },

            fzf = {
                ['ctrl-q'] = 'select-all+accept',
            },
        },
    },
    keys = {
        -- ====================================================================
        -- File Navigation
        -- ====================================================================

        {
            '<leader>ff',
            function() require('fzf-lua').files() end,
            desc = 'Find files'
        },
        {
            '<leader>fo',
            function() require('fzf-lua').oldfiles() end,
            desc = 'Recent files',
        },
        {
            '<leader>fc',
            function() require('fzf-lua').files({cwd = vim.fn.stdpath('config')}) end,
            desc = 'Find config files'
        },

        -- ====================================================================
        -- Grep
        -- ====================================================================

        {
            '<leader>fg',
            function() require('fzf-lua').live_grep() end,
            desc = 'Live grep'
        },
        {
            '<leader>fw',
            function() require('fzf-lua').grep_cword() end,
            desc = 'Grep current word',
        },
        {
            '<leader>fW',
            function() require('fzf-lua').grep_cWORD() end,
            desc = 'Grep current WORD',
        },
        {
            '<leader>fv',
            function() require('fzf-lua').grep_visual() end,
            mode = 'v',
            desc = 'Grep selection'
        },

        -- ====================================================================
        -- Help
        -- ====================================================================

        {
            '<leader>fh',
            function() require('fzf-lua').helptags() end,
            desc = 'Find help tags',
        },
        {
            '<leader>fk',
            function() require('fzf-lua').keymaps() end,
            desc = 'Find keymaps',
        },
        {
            '<leader>fb',
            function() require('fzf-lua').builtin() end,
            desc = 'FZF builtin commands',
        },
        {
            '<leader>:',
            function() require('fzf-lua').commands() end,
            desc = 'Find commands'
        },

        -- ====================================================================
        -- LSP & Diagnostics
        -- ====================================================================

        {
            '<leader>fx',
            function() require('fzf-lua').diagnostics_document() end,
            desc = 'Find diagnostics',
        },
        {
            '<leader>fX',
            function() require('fzf-lua').diagnostics_workspace() end,
            desc = 'Workspace Diagnostics'
        },
        {
            '<leader>fq',
            function() require('fzf-lua').quickfix() end,
            desc = 'Quickfix'
        },
        {
            '<leader>fs',
            function() require('fzf-lua').lsp_document_symbols() end,
            desc = 'Document Symbols'
        },
        {
            '<leader>fS',
            function() require('fzf-lua').lsp_workspace_symbols() end,
            desc = 'Workspace Symbols'
        },
        {
            '<leader>fd',
            function() require('fzf-lua').lsp_definitions() end,
            desc = 'Definitions'
        },
        {
            '<leader>fD',
            function() require('fzf-lua').lsp_declarations() end,
            desc = 'Declarations'
        },
        {
            '<leader>fi',
            function() require('fzf-lua').lsp_implementations() end,
            desc = 'Implementations'
        },

        -- ====================================================================
        -- Git Integration
        -- ====================================================================

        {
            '<leader>gf',
            function() require('fzf-lua').git_files() end,
            desc = 'Fzf Git Files'
        },
        {
            '<leader>gc',
            function() require('fzf-lua').git_commits() end,
            desc = 'Fzf Git Commits'
        },
        {
            '<leader>gb',
            function() require('fzf-lua').git_branches() end,
            desc = ' Fzf Git Branches'
        },
        {
            '<leader>gs',
            function() require('fzf-lua').git_status() end,
            desc = 'Fzf Git Status'
        },

        -- ====================================================================
        -- Miscellaneous
        -- ====================================================================

        {
            '<leader><leader>',
            function() require('fzf-lua').buffers() end,
            desc = 'Find buffers',
        },
        {
            '<leader>fr',
            function() require('fzf-lua').resume() end,
            desc = 'Resume last search',
        },
        {
            '<leader>/',
            function() require('fzf-lua').blines() end,
            desc = 'Fuzzy search in current buffer',
        },
        {
            '<leader>fm',
            function() require('fzf-lua').marks() end,
            desc = 'Find Marks'
        },
    }
}
