-- plugins/conform.lua
-- WHY: format-on-save, per-filetype formatters; stylua/shfmt from base, others added by
-- their language folders. LSP formatting is the fallback.
return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = {
    format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
      -- language folders extend this: cs = { "csharpier" }, python = { "ruff_format" }, …
    },
  },
}
