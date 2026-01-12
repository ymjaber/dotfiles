return {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {

        -- ====================================================================
        -- Sign Column Icons
        -- ====================================================================

        signs = {
            add          = { text = '┃' },
            change       = { text = '┃' },
            delete       = { text = '_' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },
        signs_staged = {
            add          = { text = '┃' },
            change       = { text = '┃' },
            delete       = { text = '_' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },

        -- ====================================================================
        -- Keymaps (on_attach)
        -- ====================================================================

        on_attach = function(buffer)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, desc)
                vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
            end

            -- ================================================================
            -- Navigation Keymaps
            -- ================================================================

            map('n', ']h', function()
                if vim.wo.diff then
                    -- In diff mode, use built-in ]c navigation
                    vim.cmd.normal({ ']c', bang = true })
                else
                    -- Use gitsigns navigation
                    gs.nav_hunk('next')
                end
            end, 'Next Hunk')

            map('n', '[h', function()
                if vim.wo.diff then
                    vim.cmd.normal({ '[c', bang = true })
                else
                    gs.nav_hunk('prev')
                end
            end, 'Prev Hunk')

            map('n', ']H', function()
                gs.nav_hunk('last')
            end, 'Last Hunk')

            map('n', '[H', function()
                gs.nav_hunk('first')
            end, 'First Hunk')

            -- ================================================================
            -- Staging and Reset Actions
            -- ================================================================

            map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', 'Stage Hunk')
            map({ "n", 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', 'Reset Hunk')
            map('n', '<leader>hS', gs.stage_buffer, 'Stage Buffer')
            map('n', '<leader>hu', gs.undo_stage_hunk, 'Undo Stage Hunk')
            map('n', '<leader>hR', gs.reset_buffer, 'Reset Buffer')

            -- ================================================================
            -- Viewing and Diff Actions
            -- ================================================================

            map('n', '<leader>hp', gs.preview_hunk_inline, 'Preview Hunk Inline')

            map('n', '<leader>hb', function()
                gs.blame_line({ full = true })
            end, 'Blame Line')

            map('n', '<leader>hB', function()
                gs.blame()
            end, 'Blame Buffer')

            map('n', '<leader>hd', gs.diffthis, 'Diff This')

            map('n', '<leader>hD', function()
                gs.diffthis('~')
            end, 'Diff This ~')

            -- ================================================================
            -- Toggle Features
            -- ================================================================

            map('n', '<leader>tb', gs.toggle_current_line_blame, 'Toggle Blame')
            map('n', '<leader>td', gs.toggle_deleted, 'Toggle Deleted')
            map('n', '<leader>tw', gs.toggle_word_diff, 'Toggle Word Diff')

            -- ================================================================
            -- Text Object
            -- ================================================================

            map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'Select Hunk')
        end,
    },
}
