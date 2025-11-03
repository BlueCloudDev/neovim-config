-- ~/.config/nvim/lua/config/dap/adapters.lua

local dap = require("dap")

-- Python Adapter (Your original definition)
dap.adapters.python = {
  type = "executable",
  command = "python3", -- Must be in your PATH
  args = { "-m", "debugpy.adapter" },
}

-- C/C++ Adapter (Example using code-lldb via Mason)
-- dap.adapters.cppdbg = {
--   type = "executable",
--   command = vim.fn.stdpath("data") .. "/mason/bin/cpptools",
-- }
