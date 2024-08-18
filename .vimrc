set nu
set rnu

set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set guifont=DejavuSansM Nerd Font:h16
" set guifont=JetbrainsMono Nerd Font:h26

call plug#begin()

" List your plugins here
Plug 'junegunn/seoul256.vim'
Plug 'jiangmiao/auto-pairs' " Auto Bracket Pair
Plug 'SirVer/ultisnips' " UltiSnippets
Plug 'mswift42/vim-themes' " Emacs Theme Pack
Plug 'rafi/awesome-vim-colorschemes' " Awesome Vim Colorschemes

call plug#end()

map <F9> :!g++ -std=c++20 -O2 -Wall % -o %:r && ./%:r <CR>

let g:UltiSnipsSnippetDirectories='~/.vim/UltiSnips'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsEditSplit="vertical"

:colorscheme seoul256-light
