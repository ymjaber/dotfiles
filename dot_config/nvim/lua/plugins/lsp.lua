-- plugins/lsp.lua
-- WHY: native vim.lsp.config/enable (0.12) with nvim-lspconfig as the definitions library.
-- Hybrid installs: big servers via pacman (§Packages), npm/.NET via mason.
return {
  { "mason-org/mason.nvim", opts = {} },
  { "seblyng/roslyn.nvim", ft = "cs", opts = {} }, -- the money language
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- every name here needs its server ON DISK; enable() only registers
      vim.lsp.enable({ "lua_ls", "bashls", "yamlls", "jsonls", "marksman" })
    end,
  },
}
