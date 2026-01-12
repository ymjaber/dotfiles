vim.g.mapleader = ' '       -- The main leader key, used for most custom mappings
vim.g.maplocalleader = '\\' -- Secondary leader for filetype-specific mappings

local map = vim.keymap.set

-- ============================================================================
-- Better Escape
-- ============================================================================

map('i', 'jk', '<ESC>', { desc = 'Exit insert mode' })

-- ============================================================================
-- Better Up/Down Navigation
-- ============================================================================

-- Allow easier navigation through wrapped long lines
map({ 'n', 'x' }, 'j', 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })
map({ 'n', 'x' }, 'k', 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })

-- ============================================================================
-- Window Navigation
-- ============================================================================

map('n', '<C-M-h>', '<C-w>h', { desc = 'Go to left window' })
map('n', '<C-M-j>', '<C-w>j', { desc = 'Go to lower window' })
map('n', '<C-M-k>', '<C-w>k', { desc = 'Go to upper window' })
map('n', '<C-M-l>', '<C-w>l', { desc = 'Go to right window' })

-- ============================================================================
-- Window Resize
-- ============================================================================

map('n', '<C-Up>', '<cmd>resize +2<CR>', { desc = 'Increase window height' })
map('n', '<C-Down>', '<cmd>resize -2<CR>', { desc = 'Decrease window height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease window width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Increase window width' })

-- ============================================================================
-- Move Lines
-- ============================================================================

map('n', '<A-j>', '<cmd>m .+1<CR>==', { desc = 'Move line down' })
map('n', '<A-k>', '<cmd>m .-2<CR>==', { desc = 'Move line up' })

map('i', '<A-j>', '<Esc><cmd>m .+1<CR>==gi', { desc = 'Move line down' })
map('i', '<A-k>', '<Esc><cmd>m .-2<CR>==gi', { desc = 'Move line up' })

map('v', '<A-j>', [[:m '>+1<CR>gv=gv]], { desc = 'Move selection down' })
map('v', '<A-k>', [[:m '<-2<CR>gv=gv]], { desc = 'Move selection up' })

-- ============================================================================
-- Buffer Navigation
-- ============================================================================

map('n', '<S-h>', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
map('n', '<S-l>', '<cmd>bnext<CR>', { desc = 'Next buffer' })
map('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'Delete buffer' })
map('n', '<leader>bD', '<cmd>bdelete!<CR>', { desc = 'Delete buffer (force)' })

-- ============================================================================
-- Tab Navigation
-- ============================================================================

map('n', '<leader>tn', '<cmd>tabnew<CR>', { desc = 'New tab' })
map('n', '<leader>tN', '<cmd>tabnew %<CR>', { desc = 'Open current beffer in a new tab' })
map('n', '<leader>td', '<cmd>tabclose<CR>', { desc = 'Close tab' })
map('n', '<leader>tl', '<cmd>tabnext<CR>', { desc = 'Next tab' })
map('n', '<leader>th', '<cmd>tabprevious<CR>', { desc = 'Previous tab' })

-- ============================================================================
-- Better Indenting
-- ============================================================================

-- Stay in visual mode after indenting.

map('v', '<', '<gv', { desc = 'Indent left' })
map('v', '>', '>gv', { desc = 'Indent right' })

-- ============================================================================
-- Centered Navigation
-- ============================================================================

map('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center' })

map('n', 'n', 'nzzzv', { desc = 'Next search result centered' })
map('n', 'N', 'Nzzzv', { desc = 'Previous search result centered' })

-- ============================================================================
-- Join Lines
-- ============================================================================

-- Join lines without cursor jumping.
map('n', 'J', 'mzJ`z', { desc = 'Join lines' })

-- ============================================================================
-- Split Windows
-- ============================================================================

map('n', '<leader>sv', '<cmd>vsplit<CR>', { desc = 'Vertical split' })
map('n', '<leader>sh', '<cmd>split<CR>', { desc = 'Horizontal split' })
map('n', '<leader>se', '<C-w>=', { desc = 'Equal split sizes' })
map('n', '<leader>sx', '<cmd>close<CR>', { desc = 'Close split' })

-- ============================================================================
-- Quick Save/Quit
-- ============================================================================

map('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save file' })

map('n', '<leader>q', '<cmd>q<CR>', { desc = 'Quit' })
map('n', '<leader>Q', '<cmd>qa!<CR>', { desc = 'Quit all (force)' })

-- ============================================================================
-- Diagnostic Navigation
-- ============================================================================

map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })

map('n', '<leader>xe', vim.diagnostic.open_float, { desc = 'Show diagnostic' })

map('n', '<leader>xl', vim.diagnostic.setloclist, { desc = 'Diagnostics to loclist' })

-- ============================================================================
-- Quickfix Navigation
-- ============================================================================

map('n', '[q', '<cmd>cprev<CR>', { desc = 'Previous quickfix' })
map('n', ']q', '<cmd>cnext<CR>', { desc = 'Next quickfix' })

-- ============================================================================
-- Toggle Options
-- ============================================================================

map('n', '<leader>uw', '<cmd>set wrap!<CR>', { desc = 'Toggle wrap' })
map('n', '<leader>us', '<cmd>set spell!<CR>', { desc = 'Toggle spell' })
map('n', '<leader>un', '<cmd>set relativenumber!<CR>', { desc = 'Toggle relative numbers' })
map('n', '<leader>ul', '<cmd>set list!<CR>', { desc = 'Toggle list chars' })
map('n', '<leader>uh', '<cmd>set hlsearch!<CR>', { desc = 'Toggle search results highlight' })

-- toggle diagnostics
local diagnostics_active = true

map('n', '<leader>ux', function()
    diagnostics_active = not diagnostics_active

    if diagnostics_active then
        vim.diagnostic.enable(true)
    else
        vim.diagnostic.enable(false)
    end
end, { desc = 'Toggle diagnostics' })

-- ============================================================================
-- Interacting With System Clipboard
-- ============================================================================

map({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
map('n', '<leader>Y', '"+y$', { desc = 'Yank to system clipboard' })

-- map({ 'n', 'v' }, '<leader>d', '"+d', { desc = 'Delete and yank to system clipboard' })
-- map('n', '<leader>D', '"+d$', { desc = 'Delete and yank to system clipboard' })

map({ 'n', 'v' }, '<leader>p', '"+p', { desc = 'Put from system clipboard' })
map('n', '<leader>P', '"+P', { desc = 'Put from system clipboard' })

-- ============================================================================
-- Avoid yanking when using x
-- ============================================================================

map({ 'n', 'v' }, 'x', '"_x')
map({ 'n', 'v' }, 'X', '"_X')

-- ============================================================================
-- Miscellaneous
-- ============================================================================

map('n', '<leader>r', [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]], { desc = 'Replace word under cursor' })

-- ============================================================================
-- Files
-- ============================================================================

map('n', '<leader>wx', '<CMD>!chmod +x %<CR>', { silent = true, desc = 'Make current file executable' })

-- yank filepath
map('n', '<leader>wp', function()
    local filePath = vim.fn.expand('%:~')   -- Get the file path relative to the home directory
    vim.fn.setreg('"', filePath)            -- Yank the file path to the registry `"`
    print('File path yanked: ' .. filePath) -- print message to configrm
end, { desc = 'Yank current file path' })

-- copy filepath to clipboard
map('n', '<leader>wP', function()
    local filePath = vim.fn.expand('%:~')                -- Get the file path relative to the home directory
    vim.fn.setreg('+', filePath)                         -- Copy the file path to the clipboard register
    print('File path copied to clipboard: ' .. filePath) -- print message to configrm
end, { desc = 'Copy current file path to system clipboard' })

-- ============================================================================
-- OSCYank Integration
-- ============================================================================

-- yank to clipboard even if on ssh
map('n', '<leader>ty', '<Plug>OSCYankOperator', { desc = 'Yank to system clipboard (OSCYank)' })
map('v', '<leader>ty', '<Plug>OSCYankVisual', { desc = 'Yank to system clipboard (OSCYank)' })

-- ============================================================================
-- Markdown
-- ============================================================================

-- Toggle markdown checkbox
-- Switches between checked [ ] and unchecked [x] states in markdown lists
local function ToggleCheckbox()
    local line = vim.api.nvim_get_current_line()
    local new_line
    -- Check if line has an unchecked box
    if line:match('^%s*-%s*%[%s%]') then
        new_line = line:gsub('^(%s*-%s*%[)%s(])', '%1x%2')
        -- Check if line has a checked box
    elseif line:match('^%s*-%s*%[x%]') then
        new_line = line:gsub('^(%s*-%s*%[)x(])', '%1 %2')
    else
        return
    end
    local lnum = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_buf_set_lines(0, lnum - 1, lnum, false, { new_line })
end

map('n', '<leader>mc', ToggleCheckbox, { desc = 'Toggle markdown checkbox' })

-- ============================================================================
-- Terminal-Specific
-- ============================================================================

map(
    'n',
    '<leader>wn',
    '<cmd>!kitty --detach<CR>',
    { desc = 'Open a new kitty window in the same directory' }
)
