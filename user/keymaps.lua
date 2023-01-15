-- see:
-- https://neovim.io/doc/user/lua.html#vim.keymap.set()

-- Shorten function name
local keymap = vim.keymap.set

-- Silent keymap option
local silent = { silent = true }
local nowait = { silent = true, nowait = true }

--Remap comma (,) as leader key
keymap("", ",", "<Nop>", opts)
vim.g.mapleader = ","

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

keymap("n", "<leader>sv", "<cmd>lua reload_nvim_conf()<CR>", silent)
keymap("n", "<leader>/", "<cmd>nohlsearch<CR>", nowait) -- clear highlighted search

-- reset folds with a single button (F5)
keymap("", "<F5>", "<ESC>zmzrzv", silent)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", silent)
keymap("n", "<C-j>", "<C-w>j", silent)
keymap("n", "<C-k>", "<C-w>k", silent)
keymap("n", "<C-l>", "<C-w>l", silent)

-- Telescope 
-- see: https://github.com/nvim-telescope/telescope.nvim#pickers
local telescope = require('telescope.builtin')
keymap("n", "<C-p>", telescope.find_files, {})
--keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
--keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>b", telescope.buffers, {})

-- LSP keymaps
-- defined as suggested here: https://neovim.io/doc/user/lsp.html
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf, noremap = true, silent = true }

    keymap("n", "gD", vim.lsp.buf.declaration, opts)
    keymap("n", "gd", vim.lsp.buf.definition, opts)
    keymap("n", "K", vim.lsp.buf.hover, opts)
    keymap("n", "gI", vim.lsp.buf.implementation, opts)
    keymap("n", "gr", vim.lsp.buf.references, opts)
    keymap("n", "gl", vim.diagnostic.open_float, opts)
    keymap("n", "<leader>ai", "<cmd>LspInfo<cr>", opts)
    keymap("n", "<leader>aI", "<cmd>Mason<cr>", opts)
    keymap("n", "<leader>aa", vim.lsp.buf.code_action, opts)
    keymap("n", "<leader>aj", vim.diagnostic.goto_next, opts)
    keymap("n", "<leader>ak", vim.diagnostic.goto_prev, opts)
    keymap("n", "<leader>ar", vim.lsp.buf.rename, opts)
    keymap("n", "<leader>as", vim.lsp.buf.signature_help, opts)
    keymap("n", "<leader>aq", vim.diagnostic.setloclist, opts)
  end
})
