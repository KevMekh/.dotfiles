"Neovim Settings/Plugins/Mappings
"Requires Neovim 0.5.0+

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
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
"LSP and Treesitter
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'nvim-lua/completion-nvim'
Plug 'glepnir/lspsaga.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Lua statusline
Plug 'hoob3rt/lualine.nvim'
"Icons pack
Plug 'kyazdani42/nvim-web-devicons'
"Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
call plug#end()
"}}}

"Plugin specific settings
"Set theme
set termguicolors
set background=dark
colorscheme onedark

"{{{ Lua-Plugins
"{{{ LSPConfig
lua << EOF
local nvim_lsp = require('lspconfig')
local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  
  -- Format on save.
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    vim.api.nvim_command [[augroup END]]
  end
  -- Completion-nvim
  require'completion'.on_attach(client, bufnr)
  protocol.CompletionItemKind = {
    '', -- Text
    '', -- Method
    '', -- Function
    '', -- Constructor
    '', -- Field
    '', -- Variable
    '', -- Class
    'ﰮ', -- Interface
    '', -- Module
    '', -- Property
    '', -- Unit
    '', -- Value
    '', -- Enum
    '', -- Keyword
    '﬌', -- Snippet
    '', -- Color
    '', -- File
    '', -- Reference
    '', -- Folder
    '', -- EnumMember
    '', -- Constant
    '', -- Struct
    '', -- Event
    'ﬦ', -- Operator
    '', -- TypeParameter
    }

end

-- DiagnosticLS
nvim_lsp.diagnosticls.setup {
  on_attach = on_attach,
  filetypes = { 'javascript', 'javascriptreact', 'json', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'markdown', 'pandoc' },
  init_options = {
    linters = {
      eslint = {
        command = 'eslint_d',
        rootPatterns = { '.git' },
        debounce = 100,
        args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
        sourceName = 'eslint_d',
        parseJson = {
          errorsRoot = '[0].messages',
          line = 'line',
          column = 'column',
          endLine = 'endLine',
          endColumn = 'endColumn',
          message = '[eslint] ${message} [${ruleId}]',
          security = 'severity'
        },
        securities = {
          [2] = 'error',
          [1] = 'warning'
        }
      },
    },
    filetypes = {
      javascript = 'eslint',
      javascriptreact = 'eslint',
      typescript = 'eslint',
      typescriptreact = 'eslint',
    },
    formatters = {
      eslint_d = {
        command = 'eslint_d',
        args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
        rootPatterns = { '.git' },
      },
      prettier = {
        command = 'prettier',
        args = { '--stdin-filepath', '%filename' }
      }
    },
    formatFiletypes = {
      css = 'prettier',
      javascript = 'eslint_d',
      javascriptreact = 'eslint_d',
      json = 'prettier',
      scss = 'prettier',
      less = 'prettier',
      typescript = 'eslint_d',
      typescriptreact = 'eslint_d',
      json = 'prettier',
      markdown = 'prettier',
    }
  }
}
-- Diagonstics custom icons
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    -- This sets the spacing and the prefix, obviously.
    virtual_text = {
      spacing = 4,
      prefix = ''
    }
  }
)
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
"LSP config mappings
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>

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

"Nvim-completion (Setup in LSPConfig: on_attach())
set completeopt=menuone,noinsert,noselect
"Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
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
