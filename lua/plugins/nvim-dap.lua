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
      "nvim-neotest/nvim-nio", -- Required for nvim-dap
    },
    config = function()
      -- General nvim-dap configuration (e.g., keymaps, adapters)
      local dap = require("dap")

      -- Example Keymaps for nvim-dap
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP: Continue" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP: Step Over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP: Step Into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP: Step Out" })
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>B", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "DAP: Set Conditional Breakpoint" })
      vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "DAP: Open REPL" })
      vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "DAP: Run Last" })

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

      -- Example Keymaps for nvim-dap-ui
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "DAP UI: Toggle" })
      vim.keymap.set("n", "<leader>de", dapui.eval, { desc = "DAP UI: Evaluate Expression (Normal mode)" })
      vim.keymap.set("v", "<leader>de", function()
        dapui.eval(nil, { enter = true })
      end, { desc = "DAP UI: Evaluate Expression (Visual mode)" })
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
        --"js-debug", -- For JavaScript/TypeScript
        --"delve", -- For Go
      },
    },
    config = function(_, opts)
      require("mason-nvim-dap").setup(opts)
    end,
  },

  -- Optional: nvim-dap-virtual-text for inline variable values
  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = true,
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {}, -- Default options are usually fine
  },
}
