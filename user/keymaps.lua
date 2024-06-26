-- see:
-- https://neovim.io/doc/user/lua.html#vim.keymap.set()

-- Shorten function name
local keymap = vim.keymap.set

-- Silent keymap option
local silent = { silent = true }
local nowait = { silent = true, nowait = true }

--Remap comma (,) as leader key
keymap("", ",", "<Nop>", nowait)
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

-- echo current filename
keymap("n", "<leader>n", ":echo @%<CR>", silent)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", silent)
keymap("n", "<C-j>", "<C-w>j", silent)
keymap("n", "<C-k>", "<C-w>k", silent)
keymap("n", "<C-l>", "<C-w>l", silent)

-- LSP keymaps
-- defined as suggested here: https://neovim.io/doc/user/lsp.html
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf, noremap = true, silent = true }

    keymap("n", "gD", vim.lsp.buf.declaration, opts)
    keymap("n", "gd", vim.lsp.buf.definition, opts)
    keymap("n", "gy", vim.lsp.buf.type_definition, opts)
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


function ReplaceQuotedStringUnderCursor()
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local start_pos, _ = line:sub(1, col+1):find('"[^"]*')
    local end_pos, _ = line:find('"', (start_pos or 0) + 1)
    if start_pos and end_pos then
        local pattern = vim.fn.escape(line:sub(start_pos+1, end_pos-1), '/')
        local keys = vim.api.nvim_replace_termcodes('%s/' .. pattern .. '//g<LEFT><LEFT>', true, false, true)
        vim.api.nvim_feedkeys(':' .. keys, 'n', false)
    end
end
keymap('n', '<Leader>sq', [[:lua ReplaceQuotedStringUnderCursor()<CR>]], {noremap = true, silent = true})
