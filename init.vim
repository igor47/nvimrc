" based on:
" https://numbersmithy.com/migrating-from-vim-to-neovim-at-the-beginning-of-2022/
" auto install vim-plug and plugins:
let plug_install = 0
let autoload_plug_path = stdpath('config') . '/autoload/plug.vim'
if !filereadable(autoload_plug_path)
    execute '!curl -fL --create-dirs -o ' . autoload_plug_path .
                \ ' https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    execute 'source ' . fnameescape(autoload_plug_path)
    let plug_install = 1
endif
unlet autoload_plug_path

" plugins begin here
call plug#begin(stdpath('config') . '/plugged')

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" no more plugins
call plug#end()
call plug#helptags()

" auto install vim-plug and plugins:
if plug_install
    PlugInstall --sync
endif
unlet plug_install

"""""""""""""""""""""""""""""
" configure treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "python",
    "bash",
    "c",
    "bibtex",
    "latex",
    "javascript",
    "typescript",
  },

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- List of parsers to ignore installing
  ignore_install = { "haskell" },
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    -- list of language that will be disabled
    disable = { "" },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = {
    -- dont enable this, messes up python indentation
    enable = false,
    disable = {},
  },
}
EOF

" Folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
