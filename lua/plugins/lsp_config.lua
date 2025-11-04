return {
  "neovim/nvim-lspconfig",
  
  -- FIX #2: Tell lazy.nvim to load nvim-cmp *before* this file
  dependencies = {
    "hrsh7th/nvim-cmp",
  },

  event = { "BufReadPre", "BufNewFile" },
  
  config = function()
    -- Use require('lspconfig') instead of vim.lsp.config
    local lspconfig = require('lspconfig') 
    local util = require('lspconfig.util')

    -- This require() is now safe because of the dependency
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.offsetEncoding = { "utf-8" }


    -- FIX #1: Define the 'on_attach' function
    local function on_attach(client, bufnr)
      -- This enables diagnostics (the squiggly lines)
      vim.diagnostic.enable(bufnr)

      -- This sets up keymaps, BUT only for this buffer
      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    end


    -- Use the standard lspconfig.gopls.setup() function
    lspconfig.gopls.setup({
      on_attach = on_attach, -- Now this variable exists
      capabilities = capabilities,
      root_dir = util.root_pattern('go.mod'),
      settings = {
        gopls = {
          buildFlags = {},
          analyses = {
            shadow = true,
            unusedparams = true,
            unusedwrite = true,
          },
          staticcheck = true,
        },
      },
    })
  end,
}
