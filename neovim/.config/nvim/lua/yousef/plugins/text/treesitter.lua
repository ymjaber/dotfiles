return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',

        config = function()
            local ts = require('nvim-treesitter')

            ts.setup {
                install_dir = vim.fn.stdpath('data') .. '/site',
            }

            ts.install({
                -- 'angular',
                -- 'arduino',
                'bash',
                -- 'c',
                'c_sharp',
                -- 'cpp',
                'css',
                'csv',
                -- 'dart',
                'diff',
                'dockerfile',
                'dot',                     -- For dot graphs
                'editorconfig',
                'fsharp',
                'git_config',
                'git_rebase',
                'gitattributes',
                'gitcommit',
                'gitignore',
                'graphql',
                -- 'haskell',
                -- 'haskell_persistent',
                'hjson',
                'html',
                'http',
                'hyprlang',                -- Hyprland configuration
                -- 'java',
                -- 'javadoc',
                'javascript',
                'jq',
                'jsdoc',
                'json',
                'json5',
                'jsonnet',
                'kitty',
                -- 'kotlin',
                'lua',
                'luadoc',
                'luap',
                'luau',
                'markdown',
                'markdown_inline',         -- Inline markdown in strings
                'mermaid',
                'nginx',
                -- 'php',
                -- 'phpdoc',
                -- 'powershell',
                'prisma',                  -- Prisma ORM
                'python',
                'query',                   -- Treesitter query language
                'razor',                   -- Razor pages (.cshtml)
                'regex',                   -- Regular expressions
                'requirements',            -- requires installing `pip install tree-sitter-requirements`
                -- 'rust',
                'scss',                    -- Sass CSS
                'sql',
                'ssh_config',
                -- 'superhtml',
                -- 'svelte',
                'tmux',
                'todotxt',
                'toml',
                'tsx',                     -- TypeScript React
                'typescript',
                'vim',                     -- Vimscript
                'vimdoc',                  -- Vim documentation
                'xml',
                'yaml',
                'zsh'
            })
        end
    },
    {
        'windwp/nvim-ts-autotag',
        ft = {
            'html',
            'xml',
            'javascript',
            'typescript',
            'javascriptreact',
            'typescriptreact',
            'svelte',
            'razor' },
        config = function()
            require('nvim-ts-autotag').setup({
                opts = {
                    enable_close = true,              -- Auto close tags when typing </
                    enable_rename = true,             -- Auto rename paired tags
                    enable_close_on_slash = false,    -- Don't close tag when typing /
                },
                -- Per-filetype configuration
                -- per_filetype = {
                --     ['html'] = {
                --         enable_close = true,
                --     },
                --     ['typescriptreact'] = {
                --         enable_close = true,
                --     },
                --     ['razor'] = {
                --         enable_close = true
                --     },
                -- },
            })
        end,
    },
}
