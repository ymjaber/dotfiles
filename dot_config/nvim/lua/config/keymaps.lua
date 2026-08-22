vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==",        { desc = "move line down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==",        { desc = "move line up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "move line down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "move line up" })
vim.keymap.set("x", "<A-j>", ":m '>+1<cr>gv=gv",        { desc = "move selection down" })
vim.keymap.set("x", "<A-k>", ":m '<-2<cr>gv=gv",        { desc = "move selection up" })

vim.keymap.set({ "n", "x" }, "<leader>y", '"+y',  { desc = "yank to clipboard" })
vim.keymap.set("n",          "<leader>Y", '"+Y',  { desc = "yank line to clipboard" })
vim.keymap.set({ "n", "x" }, "<leader>p", '"+p',  { desc = "paste from clipboard" })

vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { desc = "chmod +x file" })
