return {
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
            'node_modules',
            '.git'
          }
        },
      }

      -- Define your keybindings here (optional, but highly recommended)
      vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = '[F]ind [F]iles' })
      vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = '[F]ind [G]rep' })
      vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = '[F]ind [B]uffers' })
      vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = '[F]ind [H]elp' })
    end
  },

}
