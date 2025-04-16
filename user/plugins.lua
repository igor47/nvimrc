-- Automatically install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Install your plugins here
require("lazy").setup({
  -- plenery is a collection of functions used by lots of other plugins
  "nvim-lua/plenary.nvim",

  -- impatient speeds up neovim loading by caching lua plugins
  "lewis6991/impatient.nvim",

  -- colorscheme nightfox:
  "EdenEast/nightfox.nvim",
  "sainnhe/sonokai",

  -- cmp plugins
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",  -- buffer completions
      "hrsh7th/cmp-path",    -- path completions

      -- for lua specifically (do we need this?)
      "hrsh7th/cmp-nvim-lua",

      -- lsp-related completions
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",

      -- copilot from copilot.vim
      -- "hrsh7th/cmp-copilot",
    },
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim", tag = "0.1.3", dependencies = {'nvim-lua/plenary.nvim'},
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
  },

  -- treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- lualine
  { 'nvim-lualine/lualine.nvim', dependencies = { 'kyazdani42/nvim-web-devicons' } },

  -- indent line
  { "lukas-reineke/indent-blankline.nvim", tag = "v3.9.0", main = "ibl", opts = {} },

  -- LSP configure
  { "neovim/nvim-lspconfig" },  -- to configure built-in LSP

  --  mason
  { "williamboman/mason.nvim" },  -- installs external plugins e.g. language servers
  { "williamboman/mason-lspconfig.nvim" },

  -- colorizer sets colors on color strings -- what fun!
  "norcalli/nvim-colorizer.lua",

  -- auto-encrypt files with .pgp extension
  "jamessan/vim-gnupg",

  -- github copilot
  -- "github/copilot.vim",
  -- trying to use the lua version of the copilot plugin:
  -- see: https://tamerlan.dev/setting-up-copilot-in-neovim-with-sane-settings/
  { "zbirenbaum/copilot.lua", cmd = "Copilot", event = "InsertEnter", config = function()
      require("copilot").setup({})
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  -- syntax highlight for justfiles
  "NoahTheDuke/vim-just",
  "IndianBoy42/tree-sitter-just",

  -- syntax highlight for helm templates
  "towolf/vim-helm",
})
