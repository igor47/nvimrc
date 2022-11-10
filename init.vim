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

call plug#end()
call plug#helptags()

" auto install vim-plug and plugins:
if plug_install
    PlugInstall --sync
endif
unlet plug_install
