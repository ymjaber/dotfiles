-- plugins/blink.lua
-- WHY: the 2026 completion default (nvim-cmp is legacy). Rust-fast fuzzy, batteries-in.
-- lazydev feeds Lua completions.
return {
  "saghen/blink.cmp",
  version = "*", -- prebuilt fuzzy binary from the tagged release
  event = "InsertEnter",
  opts = {
    keymap = { preset = "default" }, -- C-y accept, C-n/C-p cycle; Enter stays a newline
    completion = { documentation = { auto_show = true } },
    signature = { enabled = true },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      per_filetype = { lua = { inherit_defaults = true, "lazydev" } },
      providers = {
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
      },
    },
  },
}
