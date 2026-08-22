-- plugins/dap.lua
-- WHY: debugging is half the money-language story. netcoredbg wired here; other adapters
-- arrive with their languages.
return {
  "mfussenegger/nvim-dap",
  dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" },
  config = function()
    local dap = require("dap")
    dap.adapters.coreclr = { type = "executable", command = "netcoredbg", args = { "--interpreter=vscode" } }
    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch dll",
        request = "launch",
        program = function() return vim.fn.input("dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file") end,
      },
    }
    require("dapui").setup()
  end,
}
