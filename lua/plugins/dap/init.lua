-- ~/.config/nvim/lua/plugins.lua (or a file required by it, e.g., /plugins/dap.lua)
return {
  -- 1. CORE DAP PLUGIN
  {
    "mfussenegger/nvim-dap",
    -- These keys will lazy-load the plugin when pressed
    keys = {
      { "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dr", function() require("dap").continue() end, desc = "DAP Run/Continue" },
      { "<leader>de", function() require("dap").restart() end, desc = "DAP Restart Session" },
      { "<leader>dc", function() require("dap").run_to_cursor() end, desc = "DAP Run to Cursor" },
      { "<leader>dn", function() require("dap").step_over() end, desc = "DAP Step Over" },
      { "<leader>di", function() require("dap").step_into() end, desc = "DAP Step Into" },
      { "<leader>do", function() require("dap").step_out() end, desc = "DAP Step Out" },
      { "<leader>dt", function() require("dap").terminate() require("dapui").close() end, desc = "DAP Terminate" },
      { "<leader>dd", function() require("dap").repl.toggle() end, desc = "DAP Toggle REPL" },
      { "<leader>dl", function() require("dap").set_log_level("TRACE") end, desc = "DAP Set Log Level (Trace)" },
      { "<leader>dL", function() require("dap").list_breakpoints() end, desc = "DAP List Breakpoints" },
      -- Go-specific keymap (can also be in the nvim-dap-go block)
      { "<leader>dgt", function() require("dap-go").debug_test() end, desc = "DAP Go Debug Test" },
    },
    dependencies = {
      -- Installs debug adapters (e.g., delve for Go)
      "jay-babu/mason-nvim-dap.nvim",
      -- Required by dap-ui
      "nvim-neotest/nvim-nio",
    },
    config = function()
      -- This file now *only* contains adapter and language configurations
      -- It should NOT contain keymaps or UI setup
      require("plugins.dap.setup")
    end,
  },

  -- 2. DAP UI PLUGIN
  {
    "rcarriga/nvim-dap-ui",
    -- This plugin depends on the core dap plugin
    dependencies = { "mfussenegger/nvim-dap" },
    -- These keys will lazy-load the UI
    keys = {
      { "<leader>du", function() require("dapui").toggle() end, desc = "DAP UI Toggle" },
      { "<leader>de", function() require("dapui").eval() end, desc = "DAP UI Eval" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      
      dap.set_log_level("TRACE")
      -- This is the correct place to call setup() for dapui
      dapui.setup({
      -- 1. We list the elements we want
        elements = {
          "scopes",
      "breakpoints",
          "stacks",
          "watches",
          "repl"
        },

        -- 2. We define the layout for those elements
        layouts = {
          {
            elements = {
               -- A column on the left for buffers & stacks
              { id = "scopes", size = 0.40 },
              { id = "breakpoints", size = 0.20 },
              { id = "stacks", size = 0.20 },
              { id = "watches", size = 0.20 },
            },
            size = 0.2, -- This whole left column takes 40% of the width
            position = "left",
          },
          {
            elements = {
              -- A column on the right for the console
              { id = "repl", size = 1.00 }
            },
            size = 0.2, -- This whole right column takes 60% of the width
            position = "right",
          },
        },

      -- ... (other config like 'floating', 'icons', etc. can go here)

     })


      vim.api.nvim_create_autocmd("BufWinEnter", {
        callback = function()
          if vim.bo.filetype == "dap-repl" then
            vim.opt_local.wrap = true
            vim.opt_local.linebreak = true
          end
        end,
      })


      -- This is the correct place for listeners that bridge dap and dapui
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

        

    end,
  },

  -- 3. VIRTUAL TEXT PLUGIN
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      -- This is the correct place to call setup() for virtual-text
      require("nvim-dap-virtual-text").setup()
    end,
  },

  -- 4. GO PLUGIN
  {
    "leoluz/nvim-dap-go",
    ft = "go", -- Lazy-loads on Go files
    dependencies = { "mfussenegger/nvim-dap" },
    config = function(opts)
      -- This is the correct place to call setup() for dap-go
      require("dap-go").setup({
        delve = {
          console = "internalConsole"
        }
      })
    end,
  },
}
