"Neovim Settings/Plugins/Mappings

"{{{ Settings
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
set foldmethod=marker
"}}}

"{{{ Plugin Manager (vim-plug)
call plug#begin('~/.local/share/nvim/plugged')
"Theme
" Using Vim-Plug
Plug 'navarasu/onedark.nvim'
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
"Lua plugins
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()
"}}}

"{{{ Custom Keybinds
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
noremap <silent> <C-Left> :vertical resize -3<CR>
noremap <silent> <C-Right> :vertical resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
 "TAB in normal mode will move to text buffer
nnoremap <silent> <TAB> :bnext<CR>
 "SHIFT-TAB will go back
nnoremap <silent> <S-TAB> :bprevious<CR>
 "Alternate way to save
nnoremap <C-s> :w<CR>
 "Alternate way to quit
nnoremap <C-Q> :q<CR>
 "Better tabbing
vnoremap < <gv
vnoremap > >gv
 "Open terminal inside nvim
map <Leader>tt :new term://fish<CR>
"}}}

"Plugin specific settings
"Set theme
colorscheme onedark
"{{{ Vim-airline settings
let g:airline_theme='deus'                  "Set theme
let g:airline_powerline_fonts=1             "Enable powerline fonts
let g:airline#extensions#tabline#enabled=1  "Enable the buffer list on top
let g:airline#extensions#branch#enabled=1   "Enable git branch in status line

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

"unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

"airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
"}}}
"{{{ fzf settings (Not configured properly)
let g:fzf_preview_window = 'right:50%'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6  }  }
"}}}
"{{{ NERDTree settings
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let g:NERDTreeWinSize=38
"}}}
"{{{ Lua-Plugins
"LSPConfig
lua << EOF
local nvim_lsp = require('lspconfig')
local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
end
-- PythonLS
nvim_lsp.pyright.setup {
  on_attach = on_attach
}
-- VimLS
nvim_lsp.vimls.setup {
  on_attach = on_attach
}
EOF
"LSP config mappings
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>

"Nvim-compe
lua << EOF
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}
EOF

"LSPSaga
lua << EOF
local saga = require('lspsaga')
saga.init_lsp_saga {
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  border_style = "round",
}
EOF
" show hover doc
nnoremap <silent>K :Lspsaga hover_doc<CR>
inoremap <silent> <C-k> <Cmd>Lspsaga signature_help<CR>
nnoremap <silent> gh <Cmd>Lspsaga lsp_finder<CR>

"Treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "toml",
    "fish",
    "php",
    "json",
    "yaml",
    "html",
    "scss"
  },
}
EOF
"}}}
