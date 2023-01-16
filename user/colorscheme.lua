-- see:
-- https://github.com/EdenEast/nightfox.nvim
--

-- our schemes want termguicolors
vim.opt.termguicolors = true

if (false) then
  require('nightfox').setup({
    options = {
      transparent = true,  -- don't set background (for tmux dimming)
      dim_inactive = true,  -- non-focused panels set to alternate color
    }
  })
  vim.cmd("colorscheme carbonfox")

-- sonokai theme them
-- see: https://github.com/sainnhe/sonokai/blob/master/doc/sonokai.txt
elseif true then
  vim.g.sonokai_style = "espresso"
  vim.g.sonokai_transparent_background = "1"
  vim.cmd("colorscheme sonokai")
end

