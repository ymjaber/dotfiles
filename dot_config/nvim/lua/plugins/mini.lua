-- plugins/mini.lua
-- WHY: three tiny, dependency-free editing primitives — pairs (auto-close), ai (better a/i
-- text-objects), surround. ONLY these three, not the whole suite.
return {
  { "nvim-mini/mini.pairs", event = "InsertEnter", opts = {} },
  { "nvim-mini/mini.ai", event = "VeryLazy", opts = {} },
  {
    "nvim-mini/mini.surround",
    keys = { "gsa", "gsd", "gsr" },
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        replace = "gsr",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        update_n_lines = "gsn",
      },
    },
  },
}
