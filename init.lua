require("config.lazy")
require("typescript-tools").setup {
 settings = {
    -- spawn additional tsserver instance to calculate diagnostics on it
    separate_diagnostic_server = true,
    -- "change"|"insert_leave" determine when the client asks the server about diagnostic
    publish_diagnostic_on = "insert_leave",
    -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
    -- "remove_unused_imports"|"organize_imports") -- or string "all"
    -- to include all supported code actions
    -- specify commands exposed as code_actions
    expose_as_code_action = {},
    -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
    -- not exists then standard path resolution strategy is applied
    tsserver_path = nil,
    -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
    -- (see 💅 `styled-components` support section)
    tsserver_plugins = {},
    -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
    -- memory limit in megabytes or "auto"(basically no limit)
    tsserver_max_memory = "auto",
    -- described below
    tsserver_format_options = {},
    tsserver_file_preferences = {},
    -- locale of all tsserver messages, supported locales you can find here:
    -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
    tsserver_locale = "en",
    -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
    complete_function_calls = false,
    include_completions_with_insert_text = true,
    -- CodeLens
    -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
    -- possible values: ("off"|"all"|"implementations_only"|"references_only")
    code_lens = "all",
    -- by default code lenses are displayed on all referencable values and for some of you it can
    -- be too much this option reduce count of them by removing member references from lenses
    disable_member_code_lens = true,
    -- JSXCloseTag
    -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
    -- that maybe have a conflict if enable this feature. )
    jsx_close_tag = {
        enable = false,
        filetypes = { "javascriptreact", "typescriptreact" },
    }
  },
}
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to Definition'})
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Get References'})
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'LSP Code Action' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP Hover' })



-- In your Neovim config (e.g., in a file loaded by lspconfig's on_attach)
vim.keymap.set("n", "<leader>e", function()
  vim.diagnostic.open_float({ focusable = true })
end, { desc = "LSP: Show line diagnostics (floating window)" })

-- For visual mode to evaluate selection
vim.keymap.set("v", "<leader>e", function()
  vim.diagnostic.open_float({ focusable = true })
end, { desc = "LSP: Show selection diagnostics (floating window)" })

vim.keymap.set({"n", "i"}, "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP: Signature Help" })

vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<cr>', { desc = 'Show diagnostics' })

-- Set line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse support
vim.opt.mouse = 'a'

-- Set tabstop and indent settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Set the leader key to space
vim.g.mapleader = " "

-- Example basic keybind (map <leader>w to save)
vim.keymap.set('n', '<leader>w', ':w<CR>')

-- Enable true color support (if your terminal supports it)
vim.opt.termguicolors = true

-- Set the default terminal background to light (adjust as needed)
--vim.opt.background = "dark"

-- Set the color scheme
vim.cmd('colorscheme vague')

vim.lsp.set_log_level("debug")
