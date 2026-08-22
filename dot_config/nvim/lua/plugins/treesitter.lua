-- plugins/treesitter.lua
-- WHY: syntax truth for highlight/motions/textobjects. MAIN branch (master frozen);
-- API ≠ pre-2025 tutorials, configured from its own README only. Needs Neovim >= 0.12.0.
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    require("nvim-treesitter").install({
      "lua",
      "vim",
      "vimdoc",
      "query",
      "bash",
      "json",
      "yaml",
      "toml", -- the formats this repo is made of
      "markdown",
      "markdown_inline",
      "diff",
      "gitcommit",
      "git_rebase",
      "c_sharp",
    })
    vim.api.nvim_create_autocmd("FileType", {
      callback = function() pcall(vim.treesitter.start) end,
    })
  end,
}
