vim.api.nvim_create_autocmd("BufReadPost", { -- reopen a file at its last cursor position + unfold
  callback = function(a)
    local m = vim.api.nvim_buf_get_mark(a.buf, '"')
    if m[1] > 0 and m[1] <= vim.api.nvim_buf_line_count(a.buf) then
      pcall(vim.cmd, 'normal! g`"zv')
    end
  end,
})
local cl = vim.api.nvim_create_augroup("ActiveCursorline", {})
vim.api.nvim_create_autocmd(
  { "WinEnter", "BufEnter" },
  { group = cl, callback = function() vim.wo.cursorline = true end }
)
vim.api.nvim_create_autocmd("WinLeave", { group = cl, callback = function() vim.wo.cursorline = false end })
