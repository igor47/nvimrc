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
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
