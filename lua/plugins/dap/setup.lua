-- ~/.config/nvim/lua/config/dap/init.lua

local dap = require("dap")

vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })

require("plugins.dap.adapters")
require("plugins.dap.configurations")
