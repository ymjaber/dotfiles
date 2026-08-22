-- plugins/conform.lua
-- WHY: format-on-save, per-filetype formatters; stylua/shfmt from base, others added by
-- their language folders. LSP formatting is the fallback.
return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  opts = {
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return nil
      end
      for _, l in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, 3, false)) do
        if l:match("GENERATED") or l:match("←%s*%S+%.tmpl") then
          return nil
        end
      end
      local name = vim.api.nvim_buf_get_name(bufnr)
      if vim.bo[bufnr].filetype == "sh" then
        return nil
      end
      if vim.bo[bufnr].filetype == "lua" and not name:match("/nvim/") then
        return nil
      end
      return { timeout_ms = 500, lsp_format = "never" }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
      -- language folders extend this: cs = { "csharpier" }, python = { "ruff_format" }, …
    },
  },
}
