-- plugins/lint.lua
-- WHY: linters LSP servers don't bundle, on write. Language folders extend the table.
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost" },
  config = function()
    require("lint").linters_by_ft = { sh = { "shellcheck" } } -- folders add their rows
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function() require("lint").try_lint() end,
    })
  end,
}
