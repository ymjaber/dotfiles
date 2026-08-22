local o = vim.opt
o.number, o.relativenumber = true, true    -- hybrid: absolute at cursor, relative for motions
o.expandtab, o.shiftwidth, o.tabstop = true, 2, 2
o.ignorecase, o.smartcase = true, true     -- lower = insensitive; any capital = exact
o.splitright, o.splitbelow = true, true
o.signcolumn = "yes"                       -- no layout jump when signs appear
o.undofile = true                          -- undo survives restarts (pairs with undotree)
o.scrolloff = 8
o.updatetime = 250                         -- faster CursorHold (gitsigns/diagnostics)
o.termguicolors = true
