local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local general = augroup('General', { clear = true })

-- ============================================================================
-- Highlight on Yank
-- ============================================================================

autocmd('TextYankPost', {
    group = general,
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 150 })
    end,
    desc = 'Highlight yanked text',
})

-- ============================================================================
-- Restore Cursor Position
-- ============================================================================

autocmd('BufReadPost', {
    group = general,
    callback = function()
        -- Get the last cursor position stored in the '"' mark
        -- This mark is automatically saved by Neovim in shada file
        local mark = vim.api.nvim_buf_get_mark(0, '"') -- 0 = current buffer

        -- Get total line count to validate the mark position
        local lcount = vim.api.nvim_buf_line_count(0)

        -- Only restore if mark is valid (line > 0 and within file bounds)
        if mark[1] > 0 and mark[1] <= lcount then
            -- pcall protects against errors (e.g., if buffer was modified)
            -- nvim_win_set_cursor: Sets cursor to [line, column]
            pcall(vim.api.nvim_win_set_cursor, 0, mark) -- 0 = current window
        end
    end,
    desc = 'Restore cursor position',
})

-- ============================================================================
-- Check for External File Changes
-- ============================================================================

-- Detect when files are modified outside Neovim (by git, other editors, etc.).

autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
    -- FocusGained: When Neovim window receives focus (e.g., Alt+Tab back)
    -- TermClose: When a terminal buffer is closed
    -- TermLeave: When leaving terminal mode
    group = general,
    callback = function()
        -- Only check regular files, not special buffers
        -- nofile = scratch buffers, help, quickfix, etc.
        if vim.o.buftype ~= 'nofile' then
            -- :checktime compares file modification time with buffer
            -- If file changed, prompts to reload or shows warning
            vim.cmd("checktime")
        end
    end,
    desc = 'Check for file changes',
})


-- ============================================================================
-- Auto-Resize Splits
-- ============================================================================

-- Equalize split sizes when terminal window is resized.

autocmd('VimResized', {
    group = general,
    callback = function()
        -- Remember current tab to return to it after resizing all tabs
        local current_tab = vim.fn.tabpagenr()

        -- :tabdo executes command in each tab
        -- :wincmd = equalizes window sizes in each tab
        vim.cmd('tabdo wincmd =')

        -- Return to the original tab
        vim.cmd('tabnext ' .. current_tab)
    end,
    desc = 'Resize splits on window resize',
})

-- ============================================================================
-- Text File Settings
-- ============================================================================

-- Enable wrapping and spell checking for prose-focused filetypes.

autocmd('FileType', {
    group = general,
    -- Filetypes where long lines and spell checking make sense
    pattern = { 'gitcommit', 'markdown', 'text' },
    callback = function()
        -- vim.opt_local: Set options only for current buffer
        -- wrap = true : Wrap long lines to fit window
        vim.opt_local.wrap = true

        -- spell = true : Enable spell checking
        vim.opt_local.spell = true
    end,
    desc = 'Wrap and spell for text files',
})

-- ============================================================================
-- Auto Create Directories
-- ============================================================================

-- Automatically create parent directories when saving a file.

autocmd('BufWritePre', {
    group = general,
    callback = function(event)
        -- Skip URL-like paths (e.g., scp://host/path, oil://path)
        -- Pattern %w%w+ matches two or more word characters before ://
        if event.match:match("^%w%w+://") then
            return
        end

        -- Get the real path (resolve symlinks) or use original if not resolvable
        -- vim.uv is the Neovim wrapper around libuv for async I/O
        local file = vim.uv.fs_realpath(event.match) or event.match

        -- Extract directory path from full file path
        -- :p = full path, :h = head (directory portion)
        -- "p" argument to mkdir means create parent directories as needed
        vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
    end,
    desc = 'Auto create directories',
})

-- ============================================================================
-- Remove Trailing Whitespace
-- ============================================================================

-- Clean up trailing whitespace before saving files.

autocmd('BufWritePre', {
    group = general,
    pattern = '*', -- All file types
    callback = function()
        -- Save current cursor position
        -- getpos(".") returns [bufnum, line, col, off]
        local save_cursor = vim.fn.getpos('.')

        -- Substitute trailing whitespace with nothing
        -- %s = whole file, \s\+ = one or more whitespace, $ = end of line
        -- e flag = don't error if no matches found
        vim.cmd([[%s/\s\+$//e]])

        -- Restore cursor position to avoid jumping to last substitution
        vim.fn.setpos('.', save_cursor)
    end,
    desc = 'Remove trailing whitespace',
})

-- ============================================================================
-- Terminal Settings
-- ============================================================================

-- Configure terminal buffers for cleaner appearance.

autocmd('TermOpen', {
    group = general,
    callback = function()
        -- Disable line numbers in terminal
        -- Numbers don't make sense in terminal context
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false

        -- Hide sign column in terminal
        -- No need for git/diagnostic signs in terminal
        vim.opt_local.signcolumn = 'no'
    end,
    desc = 'Disable numbers in terminal',
})

-- ============================================================================
-- Treesitter Highlighting
-- ============================================================================

autocmd('FileType', {
    group = general,
    pattern = '*',
    callback = function(args)
        -- Start Neovim's Tree-sitter highlighting for this buffer.
        -- pcall avoids errors if a parser isn't installed for that filetype.
        pcall(vim.treesitter.start, args.buf)
    end,
    desc = 'Enable Treesitter highlighting',
})
