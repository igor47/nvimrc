-- see:
-- https://github.com/EdenEast/nightfox.nvim
--

require('nightfox').setup({
  options = {
    transparent = true,  -- don't set background (for tmux dimming)
    dim_inactive = true,  -- non-focused panels set to alternate color
  }
})

vim.cmd("colorscheme carbonfox")

