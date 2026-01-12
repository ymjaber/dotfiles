local opt = vim.opt

-- ============================================================================
-- Line Numbers
-- ============================================================================

opt.number = true         -- Show absolute line numbers (only on the current line when relativenumber is turned on)
opt.relativenumber = true -- Show relative line numbers on other lines

opt.signcolumn = 'yes'    -- Always show the sign column (gutter for git, diagnostics)

opt.cursorline = true     -- Highlight the entire line where the cursor is

-- ============================================================================
-- Tabs & Indentation
-- ============================================================================

opt.tabstop = 4        -- Number of spaces a <Tab> character displays
opt.shiftwidth = 4     -- Number of spaces used for auto-indent (>>, <<, ==)
opt.softtabstop = 4    -- Number of spaces inserted when pressing <Tab>
opt.expandtab = true   -- Convert tabs to spaces when pressing <Tab>
opt.smartindent = true -- Auto-indent new lines based on syntax
opt.autoindent = true  -- Copy indent from current line when starting new line

-- ============================================================================
-- Line Wrapping
-- ============================================================================

opt.wrap = false       -- Don't wrap long lines to the next screen line
opt.breakindent = true -- Wrapped lines continue at same indent level
opt.linebreak = true   -- Only wrap at word boundaries (spaces, tabs)

-- ============================================================================
-- Search
-- ============================================================================

opt.ignorecase = true -- Ignore case when searching
opt.smartcase = true  -- Override ignorecase if search contains uppercase

opt.hlsearch = false  -- Don't highlight all matches of the search pattern

opt.incsearch = true  -- Show matches while typing the search pattern

-- ============================================================================
-- Appearance
-- ============================================================================

opt.termguicolors = true -- Enable 24-bit RGB color in the terminal

opt.background = 'dark'  -- Tell Neovim whether terminal has dark/light background

opt.colorcolumn = '80'   -- Display vertical line at column N

opt.showmode = false     -- Don't show mode in command line

opt.pumheight = 10       -- Maximum number of items in popup menu
opt.pumblend = 10        -- Popup menu transparency

-- ============================================================================
-- Behavior
-- ============================================================================

opt.mouse = 'a'           -- Enable mouse support in all modes

opt.splitright = true     -- New vertical splits open to the right
opt.splitbelow = true     -- New horizontal splits open below

opt.scrolloff = 10        -- Keep N lines visible above/below cursor
opt.sidescrolloff = 8     -- Keep N columns visible left/right of cursor

opt.virtualedit = 'block' -- Allow cursor to move where there's no text (only in visual block mode)

opt.inccommand = 'split'  -- Show live preview of :substitute command

-- ============================================================================
-- Completion
-- ============================================================================

-- Completion menu behavior
--   "menu"     = show popup menu even for one match
--   "menuone"  = show menu even with only one match
--   "noselect" = don't auto-select first match (user must choose)
opt.completeopt = { 'menu', 'menuone', 'noselect' }

opt.shortmess:append('c') -- Don't show ins-completion-menu messages

-- ============================================================================
-- Files
-- ============================================================================

opt.swapfile = false                            -- Don't create .swp files

opt.backup = false                              -- Don't create backup files

opt.undofile = true                             -- Enable persistent undo
opt.undodir = vim.fn.stdpath('data') .. '/undo' -- Directory for undo files (~/.local/share/nvim)

-- ============================================================================
-- Timing
-- ============================================================================

opt.updatetime = 250 -- Time (ms) before CursorHold event fires
opt.timeoutlen = 300 -- Time (ms) to wait for mapped key sequence

-- ============================================================================
-- Folding
-- ============================================================================

opt.foldmethod = 'expr'      -- How folds are determined (use foldexpr to calculate fold levels)
opt.foldexpr =
'nvim_treesitter#foldexpr()' -- Expression to calculate fold level (Uses treesitter's fold expression for accurate code folding)

opt.foldlevel = 99           -- Initial fold level when opening file (start with all folds open)
opt.foldlevelstart = 99      -- Same as foldlevel but for new buffers

opt.foldenable = true        -- Enable folding

-- ============================================================================
-- List Characters
-- ============================================================================

opt.list = true -- Show invisible characters

-- opt.listchars: Define how invisible characters are displayed
--   tab   = "» " : Tab characters shown as » followed by spaces
--   trail = "·"  : Trailing spaces shown as middle dot
--   nbsp  = "␣"  : Non-breaking spaces shown as open box
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- ============================================================================
-- Command Line Completion
-- ============================================================================

opt.wildmenu = true                -- Enable enhanced command line completion
opt.wildmode = 'longest:full,full' -- Tab completion behavior: complete to longest common, then show full menu

-- ============================================================================
-- Miscellaneous
-- ===========================================================================

opt.title = true                   -- Set terminal window title to current file name

opt.backspace = 'indent,eol,start' -- Allow backspace to delete indentation, line breaks, and pre-existing text

opt.hidden = true                  -- Allow switching buffers without saving (keeps them in background)

vim.g.editorconfig = true          -- Enable EditorConfig integration for consistent coding styles across editors
