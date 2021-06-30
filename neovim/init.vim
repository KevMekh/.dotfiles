"Neovim Settings/Plugins/Mappings

"Settings
syntax on                       "Enable syntax - on by default on nvim, but whatever
set nocompatible                "F**k vi
set nowrap                      "Display long lines on a single line
set backspace=indent,eol,start  "Enable backspace
set encoding=utf-8              "Encoding set to UTF-8
set fileencoding=utf-8          "Encoding written to file
set hidden                      "For multiple buffers
set t_Co=256                    "Use 256 colors
set tabstop=4                   "TAB-indenting
set softtabstop=4               "TAB-indenting
set shiftwidth=4                "TAB-indenting
set smarttab                    "Will format TABs correctly
set expandtab                   "Convert TABs to spaces
set autoindent                  "Automatically indent
set smartindent                 "Indent based on context
set number                      "Show line number
set incsearch                   "Incremental search
set noswapfile                  "Don't create .swap-files
set nobackup                    "Recommended by coc
set nowritebackup               "Recommended by coc
set mouse=a                     "Enable mouse
set clipboard=unnamedplus       "Global clipboard
set splitbelow                  "Split to bottom on horizontal split
set splitright                  "Split to right on vertical split
set noshowmode                  "Remove e.g. --INSERT-- display

"Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf.vim'
call plug#end()

"Plugin specific settings
 "Vim-airline settings
let g:airline_theme='deus'                  "Set theme
let g:airline_powerline_fonts=1             "Enable powerline fonts
let g:airline#extensions#tabline#enabled=1  "Enable the list of buffers
let g:airline#extensions#branch#enabled = 1 "Show git branch in status line
 "fzf setting
let g:fzf_preview_window = 'right:50%'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6  }  }

"Custom Keybinds
 "Set Leader-key (not set yet)

 "Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
 "TAB in normal mode will move to text buffer
nnoremap <TAB> :bnext<CR>
 "SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>
 "Alternate way to save
nnoremap <C-s> :w<CR>
 "Alternate way to quit
nnoremap <C-Q> :q!<CR>
 "Better tabbing
vnoremap < <gv
vnoremap > >gv
 "Open NERDTree
map <F5> :NERDTreeToggle<CR>
