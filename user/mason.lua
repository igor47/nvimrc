-- we might need lspconfig loaded already? this is how nvim-basic-ide does it
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require("mason-lspconfig").setup({
  -- see:
  -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
  ensure_installed = {
    'arduino_language_server', 'bashls', 'cssls', 'dockerls', 'eslint', 'html', 'tsserver', 'lua_ls', 'marksman', 'sqlls', 'taplo', 'vuels', 'rust_analyzer',
    -- for python
    'ruff_lsp', 'pylsp', 'pyright'
  },
  automatic_installation = true
})
