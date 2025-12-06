set nu
set rnu

set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
" set guifont=DejavuSansM Nerd Font:h16
" set guifont=JetbrainsMono Nerd Font:h26

call plug#begin()

" List your plugins here
Plug 'junegunn/seoul256.vim'
Plug 'jiangmiao/auto-pairs' " Auto Bracket Pair
Plug 'rafi/awesome-vim-colorschemes' " Awesome Vim Colorschemes

call plug#end()

:colorscheme jellybeans
