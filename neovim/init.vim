"Neovim Settings/Plugins/Mappings
"Requires Neovim >=0.5.0

"{{{ General settings
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
set ignorecase                  "Case insensitive search
set smartcase                   "Case sensitive search if specified
set foldmethod=marker
"}}}

"{{{ Plugin Manager (vim-plug)
call plug#begin('~/.local/share/nvim/plugged')
"Theme
Plug 'navarasu/onedark.nvim'
"Git
Plug 'lewis6991/gitsigns.nvim'
"LSP and Treesitter
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Lua statusline and tabline
Plug 'hoob3rt/lualine.nvim'
Plug 'romgrk/barbar.nvim'
"Icons pack; Provides dependencies as well
Plug 'kyazdani42/nvim-web-devicons'
"Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
call plug#end()
"}}}

"Plugin specific settings
"Set colors/theme
set termguicolors
set background=dark
colorscheme onedark

"{{{ Lua plugin chunks

"{{{ LSPConfig
lua << EOF
local nvim_lsp = require('lspconfig')

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
"}}}
"These keybind are already set inside on_attach() function
"nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
"nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>

"{{{ LSPSaga
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
"}}}
nnoremap <silent>K :Lspsaga hover_doc<CR>
inoremap <silent> <C-k> <Cmd>Lspsaga signature_help<CR>
nnoremap <silent> gh <Cmd>Lspsaga lsp_finder<CR>
noremap <silent> <C-j> :Lspsaga diagnostic_jump_next<CR>

"{{{ nvim-compe
set completeopt=menuone,noselect
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
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
"}}}

"{{{ Treesitter
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
    "scss",
    "lua",
    "javascript",
    "python"
  },
}
EOF
"}}}

"{{{ Git
lua << EOF
require('gitsigns').setup()
EOF
"}}}

"{{{ Lualine (Status line)
lua << EOF
local status, lualine = pcall(require, "lualine")
if (not status) then return end
lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    section_separators = {'', ''},
    component_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {
      { 'diagnostics', sources = {"nvim_lsp"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '} },
      'encoding',
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'fugitive'}
}
EOF
"}}}

"{{{ Telescope
lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  }
}
EOF
"}}}
nnoremap <silent> ;f <cmd>Telescope find_files<cr>
nnoremap <silent> ;r <cmd>Telescope live_grep<cr>
nnoremap <silent> \\ <cmd>Telescope buffers<cr>
nnoremap <silent> ;; <cmd>Telescope help_tags<cr>

"Barbar mappings
"Move to previous/next (The ones commented out dont work)
"nnoremap <silent> <Leader><TAB> :BufferNext<CR>
"nnoremap <silent> <Leader><S-TAB> :BufferPrevious<CR>
"Goto buffer in position...
"nnoremap <silent> <Leader>1 :BufferGoto 1<CR>
"nnoremap <silent> <Leader>2 :BufferGoto 2<CR>
"nnoremap <silent> <Leader>3 :BufferGoto 3<CR>
"nnoremap <silent> <Leader>4 :BufferGoto 4<CR>
"nnoremap <silent> <Leader>5 :BufferGoto 5<CR>
nnoremap <silent> <A-1> :BufferGoto 1<CR>
nnoremap <silent> <A-2> :BufferGoto 2<CR>
nnoremap <silent> <A-3> :BufferGoto 3<CR>
nnoremap <silent> <A-4> :BufferGoto 4<CR>
nnoremap <silent> <A-5> :BufferGoto 5<CR>

"}}}

"{{{ Custom Keybinds
"Set Leader-key
let mapleader=" "
"Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l
"Split window
nnoremap <Leader>ss :split<CR>
nnoremap <Leader>sv :vsplit<CR>
"Make adjusting split sizes a bit more friendly
noremap <silent> <C-Left> :vertical resize -3<CR>
noremap <silent> <C-Right> :vertical resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
"TAB in normal mode will move to text buffer
nnoremap <silent> <Leader><TAB> :bnext<CR>
"SHIFT-TAB will go back
nnoremap <silent> <Leader><S-TAB> :bprevious<CR>
"Alternate way to save
nnoremap <C-s> :w<CR>
"Alternate way to quit
nnoremap <C-q> :q<CR>
"Better tabbing
vnoremap < <gv
vnoremap > >gv
"Open terminal inside nvim
map <Leader>tt :new term://fish<CR>
"}}}
