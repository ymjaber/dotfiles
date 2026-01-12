return {
    'esensar/nvim-dev-container',

    cmd = {
        'DevcontainerBuild',              -- Build container image
        'DevcontainerImageRun',           -- Run built image
        'DevcontainerBuildAndRun',        -- Build + run
        'DevcontainerBuildRunAndAttach',  -- Build + run + attach
        'DevcontainerComposeUp',          -- docker-compose up
        'DevcontainerComposeDown',        -- docker-compose down
        'DevcontainerComposeRm',          -- docker-compose rm
        'DevcontainerStartAuto',          -- Start with auto-detection
        'DevcontainerStartAutoAndAttach', -- Start + attach
        'DevcontainerAttachAuto',         -- Attach to running
        'DevcontainerStopAuto',           -- Stop current container
        'DevcontainerStopAll',            -- Stop all containers
        'DevcontainerRemoveAll',          -- Remove all containers
        'DevcontainerLogs',               -- View logs
        'DevcontainerOpenNearestConfig',  -- Open devcontainer.json
        'DevcontainerEditNearestConfig',  -- Edit devcontainer.json
    },
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- For JSON parsing
    },

    keys = {
        { '<leader>Dc', '<cmd>DevcontainerBuildAndRun<cr>',       desc = 'Build & Run Container' },
        { '<leader>Da', '<cmd>DevcontainerAttachAuto<cr>',        desc = 'Attach to Container' },
        { '<leader>Ds', '<cmd>DevcontainerStopAuto<cr>',          desc = 'Stop Container' },
        { '<leader>Dl', '<cmd>DevcontainerLogs<cr>',              desc = 'Container Logs' },
        { '<leader>De', '<cmd>DevcontainerEditNearestConfig<cr>', desc = 'Edit devcontainer.json' },
    },

    opts = {
        generate_commands = true,
        cache_dir = vim.fn.stdpath('cache') .. '/devcontainer',

        -- ====================================================================
        -- Terminal Handler
        -- ====================================================================

        terminal_handler = function(command)
            local ok, toggleterm = pcall(require, 'toggleterm')
            if ok then
                local Terminal = require('toggleterm.terminal').Terminal
                local term = Terminal:new({
                    cmd = command,
                    direction = 'float',
                    close_on_exit = false, -- Keep open to see output
                })
                term:toggle()
            else
                vim.cmd('terminal ' .. command)
            end
        end,

        -- ====================================================================
        -- Mount Configuration
        -- ====================================================================

        attach_mounts = {
            neovim_config = {
                enabled = true,
                options = { 'readonly' },
            },

            neovim_data = {
                enabled = false,
                options = {},
            },
            neovim_state = {
                enabled = false,
                options = {},
            },
        },
        always_mount = {},

        -- ====================================================================
        -- Container Runtime Configuration
        -- ====================================================================

        container_runtime = 'docker',
        compose_command = "docker-compose",
    },
}
