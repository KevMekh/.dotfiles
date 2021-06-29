"Settings
syntax on
set hidden
set t_Co=256
set tabstop=4 softtabstop=4
set expandtab
set smarttab
set smartindent
set autoindent
set number
set incsearch
set noswapfile
set mouse=a


let g:airline_theme='deus' "Set theme
let g:airline_powerline_fonts=1 "Enable powerline fonts
let g:airline#extensions#tabline#enabled=1 "Enable the list of buffers
let g:airline#extensions#branch#enabled = 1 "Show git branch in status line

"Plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()
