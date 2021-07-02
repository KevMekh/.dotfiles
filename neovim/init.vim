"Neovim Settings/Plugins/Mappings

"Settings
syntax on                       "Enable syntax - on by default on nvim, but whatever
set nocompatible                "F**k vi
set nowrap                      "Display long lines on a single line
set backspace=indent,eol,start  "Enable backspace
set encoding=utf-8              "Encoding set to UTF-8
set fileencoding=utf-8          "Encoding written to file
set hidden                      "Enabling multiple buffers
set t_Co=256                    "Enable 256 colors on terminal if supported
set tabstop=4                   "TAB-indenting
set softtabstop=4               "TAB-indenting
set shiftwidth=4                "TAB-indenting
set smarttab                    "Will format TABs and Spaces correctly
set expandtab                   "Convert TABs to spaces
set autoindent                  "Automatically indent
set smartindent                 "Indent based on previous lines
set number                      "Show line number
set incsearch                   "Search highlighting
set smartcase                   "Case sensitive search
set noswapfile                  "Don't create .swap-files
set nobackup                    "Recommended by coc
set nowritebackup               "Recommended by coc
set mouse=a                     "Enable mouse
set clipboard=unnamedplus       "Global clipboard - Requires extra steps in WSL
set splitbelow                  "Split to bottom on horizontal split
set splitright                  "Split to right on vertical split
set noshowmode                  "Remove e.g. --INSERT-- display
set laststatus=2                "Always show statusline
set path+=**					"Searches current directory recursively.
set wildmenu					"Display all matches when tab complete.


"Plugin Manager (vim-plug)
call plug#begin('~/.local/share/nvim/plugged')
"Start menu
Plug 'mhinz/vim-startify'
"Powerline statusbar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
"File Managing
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf.vim'
"QoL
Plug 'christoomey/vim-tmux-navigator'
Plug 'liuchengxu/vim-which-key'
call plug#end()


"Custom Keybinds
 "Set Leader-key
let mapleader=" "
 "Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
 "Split window
nnoremap <Leader>ss :split<CR>
nnoremap <Leader>sv :vsplit<CR>
 "Make adjusting split sizes a bit more friendly
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Down> :resize +3<CR>
noremap <silent> <C-Up> :resize -3<CR>
 "TAB in normal mode will move to text buffer
nnoremap <silent> <TAB> :bnext<CR>
 "SHIFT-TAB will go back
nnoremap <silent> <S-TAB> :bprevious<CR>
 "Alternate way to save
nnoremap <C-w> :w<CR>
 "Alternate way to quit
nnoremap <C-Q> :q<CR>
 "Better tabbing
vnoremap < <gv
vnoremap > >gv
 "Open terminal inside nvim
map <Leader>tt :new term://fish<CR>


"Plugin specific settings
 "Vim-airline settings
let g:airline_theme='deus'                  "Set theme
let g:airline_powerline_fonts=1             "Enable powerline fonts
let g:airline#extensions#tabline#enabled=1  "Enable the list of buffers
let g:airline#extensions#branch#enabled = 1 "Show git branch in status line
 "fzf setting
let g:fzf_preview_window = 'right:50%'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6  }  }
 "Open NERDTree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let g:NERDTreeWinSize=38

