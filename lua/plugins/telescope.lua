return {
  { "airblade/vim-rooter" },
  {
    "smartpde/telescope-recent-files",
    -- Make sure it loads after telescope.nvim
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      -- Load the extension
      require("telescope").load_extension("recent_files")
    end,
  },
  {
   'nvim-telescope/telescope.nvim',
    tag = '0.1.5', -- Use the latest stable tag
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      file_ignore_patterns = {
        'node_modules',
        '.git'
      }
    },
    config = function()
      require('telescope').setup {
        -- You can add your default configuration here, or leave it empty for defaults
        defaults = {
          file_ignore_patterns = {
            "^node_modules/",
            "/node_modules/",
          }
        },
     }
     extensions = {
     	frecency = {
	      ignore_patterns = {}
	    }
     }

      -- Define your keybindings here (optional, but highly recommended)
      vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = '[F]ind [F]iles' })
      vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = '[F]ind [G]rep' })
      vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = '[F]ind [B]uffers' })
      vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = '[F]ind [H]elp' })
      vim.keymap.set("n", "<Leader><Leader>",[[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]], {noremap = true, silent = true})
    end
  },
}
