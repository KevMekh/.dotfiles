"NeoViM Settings and Plugins

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
set clipboard=unnamedplus

"Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf.vim'
call plug#end()

"Vim-airline settings
let g:airline_theme='deus' "Set theme
let g:airline_powerline_fonts=1 "Enable powerline fonts
let g:airline#extensions#tabline#enabled=1 "Enable the list of buffers
let g:airline#extensions#branch#enabled = 1 "Show git branch in status line

"fzf setting
let g:fzf_preview_window = 'right:50%'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6  }  }

"Custom Keybinds
map <F5> :NERDTreeToggle<CR>
