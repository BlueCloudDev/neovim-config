return {
  -- ... other plugins ...
  {'hrsh7th/nvim-cmp',
    dependencies = {
      {'hrsh7th/cmp-buffer'},     -- Source for buffer completions
      {'hrsh7th/cmp-path'},       -- Source for file path completions
      {'saadparwaiz1/cmp_luasnip'}, -- Source for snippet completions
      {'hrsh7th/cmp-nvim-lsp'},   -- Source for LSP completions
      {'L3MON4D3/LuaSnip'},       -- Snippet engine (required by cmp_luasnip)
      -- Add any other cmp sources you want (e.g., 'hrsh7th/cmp-nvim-lua')
    },
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          --['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
	  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort()
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        }),
      })
    end
  },
  -- ... other plugins ...
}
