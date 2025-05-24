return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lspconfig = require("lspconfig")

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		-- fixes WARNING Found buffers attached to multiple clients with different position encodings.
		capabilities.offsetEncoding = { "utf-8" }

		local util = require("lspconfig.util")
		lspconfig.clangd.setup({
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
	end,
}
