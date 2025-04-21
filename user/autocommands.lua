-- remove trailing whitespace
-- autocmd FileType python,php,ruby,javascript,javascript.jsx autocmd BufWritePre <buffer> :%s/\s\+$//e
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.py", "*.rb", "*.js", "*.ts", "*.tsx", "*.jsx", "*.php" },
  callback = function()
		vim.cmd([[%s/\s\+$//e]])
  end,
})


-- close lsp pop-ups by pressing 'q'
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]])
	end,
})

-- enable spelling in text files
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown", "email" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

-- do something when window is resized? not sure what
--vim.api.nvim_create_autocmd({ "VimResized" }, {
--	callback = function()
--		vim.cmd("tabdo wincmd =")
--	end,
--})

-- not sure about this one either
--vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
--	callback = function()
--		vim.cmd("quit")
--	end,
--})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
	callback = function()
		vim.cmd("hi link illuminatedWord LspReferenceText")
	end,
})

-- we don't use https://github.com/RRethy/vim-illuminate
-- vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
-- 	callback = function()
-- 	local line_count = vim.api.nvim_buf_line_count(0)
-- 		if line_count >= 5000 then
-- 			vim.cmd("IlluminatePauseBuf")
-- 		end
-- 	end,
-- })
--
-- refresh files that changed outside of vim
-- Enable autoread globally
vim.o.autoread = true

local refresh_group = vim.api.nvim_create_augroup("AutoRefreshFiles", { clear = true })

-- Check file changes on focus, when a window is entered, and when the cursor is idle for some time
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = refresh_group,
  pattern = "*",
  callback = function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})

-- Notification after file changes detected
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = refresh_group,
  pattern = "*",
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.INFO)
  end,
})
