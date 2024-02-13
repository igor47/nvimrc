-- set up LSP diagnostics
local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = false, -- disable virtual text
  signs = {
    active = signs, -- show signs
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

-- update lsp capabilities with the extras from nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_status_ok then
  capabilities = cmp_nvim_lsp.default_capabilities()
end

-- we need to set up each language server we use
-- see:
-- https://github.com/neovim/nvim-lspconfig#suggested-configuration
local lspconfig = require("lspconfig")

-- allow picking different LSP servers in different projects
if PYTHON_LSP == nil then
  PYTHON_LSP = 'pyright'
end

-- we set up all available lsp servers automatically
require("mason-lspconfig").setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function (server_name) -- default handler (optional)
    lspconfig[server_name].setup({
      capabilities = capabilities,
    })
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  ["lua_ls"] = function ()
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }
          }
        }
      }
    })
  end,
  ["ruff_lsp"] = function ()
    lspconfig.ruff_lsp.setup({
      capabilities = capabilities,
      on_attach = function (client, bufnr)
        -- Disable hover in favor of Pyright/pylsp/jedi
        client.server_capabilities.hoverProvider = false
      end,
    })
  end,
  ["pylsp"] = function ()
    if PYTHON_LSP ~= 'pylsp' then return end

    -- based on https://jdhao.github.io/2023/07/22/neovim-pylsp-setup/
    lspconfig.pylsp.setup({
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 200,
      },
      settings = {
        pylsp = {
          plugins = {
            -- formatter options all handled by ruff
            black = { enabled = false },
            autopep8 = { enabled = false },
            yapf = { enabled = false },
            -- linter options also handled by ruff
            pylint = { enabled = false },
            pyflakes = { enabled = false },
            pycodestyle = { enabled = false },
            -- import sorting also handled by ruff
            pylsp_isort = { enabled = false },
            -- type checker
            pylsp_mypy = {
              enabled = true,
              -- the next two are incompatible; lets keep live mode on, performance may suffer
              live_mode = true,
              dmypy = false,
              -- not sure if this does anything here...
              strict = true,
            },
            -- auto-completion options
            jedi_completion = { fuzzy = true },
          },
        },
      },
    })
  end,
  ["pyright"] = function()
    if PYTHON_LSP ~= 'pyright' then return end
    lspconfig.pyright.setup({
      capabilities = capabilities,
    })
  end
})
