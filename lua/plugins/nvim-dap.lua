-- lua/plugins/dap.lua

return {
  -- nvim-dap: The core Debug Adapter Protocol client
  {
    "mfussenegger/nvim-dap",
    -- You can set lazy = true here to only load it when you start debugging.
    -- Common triggers are 'event = "UIEnter"' or 'cmd = "DapToggleBreakpoint"'.
    -- Or, you can set it as a dependency of nvim-dap-ui and let dap-ui handle lazy loading.
    lazy = true,
    dependencies = {
      "rcarriga/nvim-dap-ui",             -- UI for DAP
      "nvim-neotest/nvim-nio",           -- Dependency for nvim-dap-ui
      "theHamsta/nvim-dap-virtual-text", -- Shows virtual text for variables
      "jay-babu/mason-nvim-dap.nvim",    -- Integrates Mason with DAP
    },
    config = function()
      -- General nvim-dap configuration (e.g., keymaps, adapters)
      local dap = require("dap")
      local dapui = require("dapui")
      local dap_virtual_text = require("nvim-dap-virtual-text")

      dap_virtual_text.setup()
      dapui.setup()
      
      -- Automatically open/close DAP UI
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

      vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })

      -- Basic debugging commands
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dr", dap.continue, { desc = "DAP Run/Continue" })
      vim.keymap.set("n", "<leader>dc", dap.run_to_cursor, { desc = "DAP Run to Cursor" })
      vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "DAP Step Over" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "DAP Step Into" })
      vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "DAP Step Out" })
     -- vim.keymap.set("n", "<leader>dK", dap.hover_variables, { desc = "DAP Hover Variables" })
      vim.keymap.set("n", "<leader>dt", function() dap.terminate() dapui.close() end, { desc = "DAP Terminate" })
      vim.keymap.set("n", "<leader>dd", dap.repl.toggle, { desc = "DAP Toggle REPL" })
      vim.keymap.set("n", "<leader>dl", function() dap.set_log_level("TRACE") dap.trace_next_request() end, { desc = "DAP Set Log Level (Trace)" })
      vim.keymap.set("n", "<leader>dL", dap.list_breakpoints, { desc = "DAP List Breakpoints" })
      -- vim.keymap.set("n", "<leader>dS", dap.scopes, { desc = "DAP Scopes" })
      
      -- DAP UI specific commands
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "DAP UI Toggle" })
      vim.keymap.set("n", "<leader>de", dapui.eval, { desc = "DAP UI Eval" })
     
      -- Go-specific commands (from nvim-dap-go)
      vim.keymap.set("n", "<leader>dgt", function() require("dap-go").debug_test() end, { desc = "DAP Go Debug Test" })
      

      -- Set up DAP adapters for languages (example for Python with debugpy)
      -- This is crucial for debugging specific languages.
      -- You'll need to install the debug adapter (e.g., `debugpy` for Python)
      -- using your system's package manager or `mason.nvim`.
      dap.adapters.python = {
        type = "executable",
        command = "python3", -- Or the path to your python executable with debugpy
        args = { "-m", "debugpy.adapter" },
      }

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            return vim.fn.exepath("python3") -- Or specific python env path
          end,
        },
      }

      -- You'll add more adapters and configurations for other languages you debug.
      -- Refer to `nvim-dap` documentation or `mason-nvim-dap.nvim` for more.
    end,
  },

  -- Go-specific DAP extension
  {
    "leoluz/nvim-dap-go",
    ft = "go", -- Only load this plugin for Go files
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-go").setup({
        -- Optional: Configure Delve options if needed
        -- delve = {
        --   -- detached = false, -- Set to true if you want dlv to run in a separate terminal process
        -- },
        -- -- Example custom configurations (can also be defined in .vscode/launch.json)
        -- dap_configurations = {
        --   {
        --     type = "go",
        --     name = "Launch file",
        --     request = "launch",
        --     program = "${file}",
        --   },
        --   {
        --     type = "go",
        --     name = "Launch current directory",
        --     request = "launch",
        --     program = "${workspaceFolder}",
        --   },
        --   {
        --     type = "go",
        --     name = "Test current file",
        --     request = "launch",
        --     mode = "test",
        --     program = "${file}",
        --   },
        -- },
      })
    end,
  },

  -- nvim-dap-ui: The graphical interface for DAP
  {
    "rcarriga/nvim-dap-ui",
    -- nvim-dap-ui typically loads when a DAP session starts.
    -- This `lazy = true` means it won't load until `nvim-dap` is used,
    -- which is usually triggered by a keymap or command.
    lazy = true,
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio", -- nvim-dap-ui also depends on nvim-nio
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup({
        -- Your DAP UI configuration goes here.
        -- These are common options, check :help dapui.setup for full details.
        icons = {
          expanded = "▾",
          collapsed = "▸",
          current_frame = "🔥",
        },
        layouts = {
          {
            elements = {
              -- You can customize the elements and their order
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 40, -- Can be a percentage (e.g., 0.30) or absolute lines
            position = "left", -- Can be "left", "right", "top", "bottom"
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 0.25,
            position = "bottom",
          },
        },
        controls = {
          -- Set to false to disable all controls (buttons)
          enabled = true,
          -- You can specify icons for the controls
          icons = {
            disconnect = "⏏",
            step_over = "▸",
            step_into = "⇣",
            step_out = "⇡",
            step_back = "↶",
            run_last = "⟲",
            terminate = "⏹",
            pause = "⏸",
            play = "▶",
          },
        },
      })

      -- Automatically open and close the UI with DAP events
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end

    end,
  },

  -- mason-nvim-dap.nvim: Helps install debug adapters via mason.nvim
  {
    "jay-babu/mason-nvim-dap.nvim",
    lazy = true,
    dependencies = {
      "williamboman/mason.nvim", -- Mason is required for mason-nvim-dap.nvim
    },
    opts = {
      -- List of debuggers to install automatically
      -- Example: "python", "typescript", "go", "java"
      automatic_installation = true,
      ensure_installed = {
        -- Add the debug adapters you need here
        "debugpy", -- For Python
        "js-debug", -- For JavaScript/TypeScript
        "delve", -- For Go
        "go"
      },
    },
    config = function(_, opts)
      require("mason-nvim-dap").setup(opts)
    end,
  },

}
