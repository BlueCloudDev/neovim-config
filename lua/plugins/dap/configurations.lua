-- ~/.config/nvim/lua/config/dap/configurations.lua

local dap = require("dap")

-- Python Configurations
dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch Current File",
    program = "${file}",
    pythonPath = function()
      return vim.fn.exepath("python3") -- or path to virtual environment
    end,
  },
  {
    type = "python",
    request = "attach",
    name = "Attach to Debugpy",
    processId = require('dap.utils').pick_process,
    
  },
}

-- Go Configurations are usually handled by nvim-dap-go's setup, 
-- but you can add custom ones here if needed:
dap.configurations.go = {
   {
     type = "go",
     name = "Debug Project Root",
     request = "launch",
     program = "${workspaceFolder}",
     outputMode = "remote"
   }
}
