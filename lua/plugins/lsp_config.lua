return {
  "neovim/nvim-lspconfig",
  
  -- FIX #2: Tell lazy.nvim to load nvim-cmp *before* this file
  dependencies = {
    "hrsh7th/nvim-cmp",
  },


  config = function()
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

    lspconfig = require("lspconfig")
    lspconfig.gopls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = {"gopls"},
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = util.root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
            },
          },
        },
      }

    local lspconfig = require('lspconfig')
    local vue_ls_path = '/home/jblau/.nvm/versions/node/v24.11.1/lib/node_modules/@vue/language-server/bin/vue-language-server.js'
    -- Configuration for the Vue Language Server
    -- lspconfig.volar.setup {
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    --   filetypes = { 'vue' }, -- ONLY activate on .vue files
    --   init_options = {
    --     vue = {
    --       -- This is the key: allows tsserver to handle the TS logic internally
    --       hybridMode = true,
    --       -- You can specify the Vue version if needed, but Vue 3 is default
    --       version = 3,
    --     },
    --     -- Point to your project's node_modules/typescript if possible
    --     typescript = {
    --       tsdk = "node_modules/typescript/lib" 
    --     }
    --   },
    -- }

        -- Configuration for the Standard TypeScript Language Server
    -- Use 'tsserver' if you are using Mason/lspconfig default
    -- OR use 'typescript-tools' if you prefer that dedicated plugin
    -- lspconfig.tsserver.setup {
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    --   -- Activate on all files *except* .vue
    --   filetypes = { 
    --     'typescript', 
    --     'javascript', 
    --     'javascriptreact', 
    --     'typescriptreact' 
    --   },
    --   -- Recommended: Disable the built-in tsserver diagnostics to avoid conflicts
    --   -- with vue_ls reporting the same diagnostics inside SFCs.
    --   settings = {
    --     typescript = {
    --       disableAutomaticTypeAcquisition = true
    --     }
    --   }
    -- }

    --vim.lsp.config("vue_ls", {
    --  on_attach = on_attach,
    --  capabilities = capabilities,
    --  init_options = {
    --    vue = {
    --      hybridMode = false,
    --    },
    --  },
    --  filetypes = { 'vue', 'javascript', 'typescript' }
    --})

    --vim.lsp.config("ts_ls", {
    --  on_attach = on_attach,
    --  capabilities = capabilities,
    --})

    vim.lsp.config("vtsls", {
      on_attach = on_attach,
      capabilities = capabilities,
      --/home/jblau/.nvm/versions/node/v24.11.1/lib/node_modules/@vue/
      settings = {
        vtsls = {
          tsserver = {
            globalPlugins = {
              {
                name = '@vue/typescript-plugin',
                location = vim.fn.expand('$HOME/.nvm/versions/node/v24.11.1/lib/node_modules/@vue/language-server'), -- Adjust path if not using Mason
                languages = { 'vue' },
                configNamespace = 'typescript',
              },
            },
          },
        },
      },
      filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    })

    -- This is apparently for Vue 2?
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    --   filetypes = { 'vue', 'javascript', 'typescript', 'html', 'css', 'scss' },
    --   settings = {
    --     vetur = {
    --       -- You can put other vetur-specific settings here
    --       completion = {
    --         autoImport = true,
    --       }
    --     },
        
    --     -- THIS IS THE FIX:
    --     -- We are configuring the internal HTML service
    --     -- that VLS uses.
    --     html = {
    --       suggest = {
    --         -- This disables completions for standard HTML 
    --         -- attributes, which includes 'onclick'.
    --         attributes = false, 
            
    --         -- You can also set this to false to be safe,
    --         -- though 'attributes = false' usually gets it.
    --         events = false 
    --       }
    --     }
    --   }
    -- })

    -- vim.lsp.config("tailwindcss", {
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    --   filetypes = { 'vue', 'javascript', 'typescript', 'html', 'css', 'scss' }
    -- })
  end,
}
