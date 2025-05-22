return {
  {
	  'nvim-treesitter/nvim-treesitter',
	  build = ':TSUpdate',
	  config = function()
	    require('nvim-treesitter.configs').setup {
	      -- Add languages you want to ensure are installed here
	      ensure_installed = { 'c', 'cpp', 'lua', 'python', 'javascript', 'typescript', 'html', 'css' },

	      -- Enable highlighting
	      highlight = {
		enable = true,
		-- Setting this to `true` will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `false` if you experience any issues with syntax highlighting.
		additional_vim_regex_highlighting = true,
	      },
	      indent = { enable = true },
	      -- You can enable more modules here, see the documentation:
	      -- :help nvim-treesitter-modules
	    }
	  end
	}
}
