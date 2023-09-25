local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
  git = {
    clone_timeout = 300, -- Timeout, in seconds, for git clones
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Have packer manage itself
  use { "wbthomason/packer.nvim" }

  -- plenery is a collection of functions used by lots of other plugins
  use "nvim-lua/plenary.nvim"

  -- impatient speeds up neovim loading by caching lua plugins
  use { "lewis6991/impatient.nvim" }

  -- colorscheme nightfox:
  use "EdenEast/nightfox.nvim"
  use "sainnhe/sonokai"

  -- cmp plugins
  use { "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer",  -- buffer completions
      "hrsh7th/cmp-path",    -- path completions
      "saadparwaiz1/cmp_luasnip",  -- complete snippets

      -- for lua specifically (do we need this?)
      "hrsh7th/cmp-nvim-lua",

      -- lsp-related completions
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",

      -- copilot from copilot.vim
      "hrsh7th/cmp-copilot",
    },
  }

  -- snippets
  use { "L3MON4D3/LuaSnip" } --snippet engine
  use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

  -- telescope
  use { "nvim-telescope/telescope.nvim", tag = "0.1.3", requires = { {'nvim-lua/plenary.nvim'} } }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- treesitter
  use { "nvim-treesitter/nvim-treesitter", tag = "v0.9.1" }

  -- lualine
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }

  -- indent line
  use { "lukas-reineke/indent-blankline.nvim", tag = "v2.20.2" }

  -- LSP configure
  use { "neovim/nvim-lspconfig" }  -- to configure built-in LSP

  --  mason
  use { "williamboman/mason.nvim" }  -- installs external plugins e.g. language servers
  use { "williamboman/mason-lspconfig.nvim" }

  -- null-ls (for formatters and linters)
  use { "jose-elias-alvarez/null-ls.nvim" }

  -- colorizer sets colors on color strings -- what fun!
  use { "norcalli/nvim-colorizer.lua" }

  -- auto-encrypt files with .pgp extension
  use "jamessan/vim-gnupg"

  -- github copilot
  use { "github/copilot.vim" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
