-- see:
-- https://neovim.io/doc/user/lua.html#vim.opt
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.laststatus = 0  -- never display status line

-- searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

vim.opt.title = true
vim.opt.scrolloff=3   -- scroll before reaching the bottom
vim.opt.visualbell = true    -- visual bell
vim.opt.showcmd = true      -- show the command i'm about to use as i type it
vim.opt.tildeop = true          -- ~ behaves like an operator
vim.opt.shortmess:append("mr")  -- shorten the interactive prompts a bit
vim.opt.history=1000  -- longer command history

-- disable mouse -- maybe we should re-consider this in neovim?
vim.opt.mouse=''

-- tabs and buffers
vim.opt.tabpagemax=50      -- 50 tabs max instead of the default 10
vim.opt.hidden=true        -- allow hidden buffers

-- default to system clipboard
vim.opt.clipboard = "unnamedplus"

-- my tab/whitespace settings: 2 spaces per tab (will need something special in python/black projects)
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- folds using treesitter
vim.opt.foldmethod = "indent"
--vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
