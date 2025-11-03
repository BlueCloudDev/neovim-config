return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lspconfig = vim.lsp.config
<<<<<<< HEAD
=======
    local util = require('lspconfig.util')
>>>>>>> 4d5ee0a (added dap go)
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		-- fixes WARNING Found buffers attached to multiple clients with different position encodings.
		capabilities.offsetEncoding = { "utf-8" }

<<<<<<< HEAD
		local util = vim.lsp.util
=======
>>>>>>> 4d5ee0a (added dap go)
		vim.lsp.config('clangd', {
		    capabilities = capabilities,
		    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "cu" }, -- Add 'cuda' here
		    cmd = {
		        "clangd-17",
			"--background-index",
		        "--clang-tidy",
		        "--header-insertion=iwyu",
		        "--completion-style=detailed",
		        "--function-arg-placeholders",
		        "--fallback-style=llvm",
		        -- Add CUDA-specific flags
		        --"--cuda-path=/usr/local/cuda", -- **Important:** Adjust this path to your CUDA installation
		        -- You might need other flags depending on your project, e.g.:
		        -- "-xcuda", -- Force clangd to treat files as CUDA
		        -- "-std=c++17", -- or c++20, or gnu++17 etc.
		        -- "-I/path/to/your/project/cuda/headers", -- if you have custom CUDA headers
		    },
		    -- Other settings as needed
		    -- root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git", ".clangd"),
		})


		vim.lsp.config('gopls', {
		  on_attach = on_attach,
      root_dir = util.root_pattern('go.mod'),
		  -- cmd = { "gopls" }, -- gopls is usually found in PATH, so this is often not needed
		  settings = {
		    gopls = {
		      buildFlags = {}, -- Add any specific build flags if needed
		      -- You can configure various gopls settings here.
		      -- For example, to enable analyses:
		      analyses = {
      			shadow = true,
			      unusedparams = true,
			      unusedwrite = true,
		      },
		      staticcheck = true, -- Enables staticcheck analysis (recommended)
		      -- For more options, see `gopls help settings` or :help gopls-settings
		      -- Example for UI.Completion documentation on hover:
		      ui = {
			      completion = {
			        insertTextFormat = "Snippet", -- or "PlainText"
			        documentation = {
			          enable = true,
			        },
			      },
		      },
		    },
		  },
		})
	end,
}
