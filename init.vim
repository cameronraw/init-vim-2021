set exrc
set guicursor=
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set completeopt=menuone,noinsert,noselect
set signcolumn=yes

set cmdheight=2
set updatetime=50
set shortmess+=c
set colorcolumn=80

call plug#begin('~/.vim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'gruvbox-community/gruvbox'

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

call plug#end()

colorscheme gruvbox
highlight Normal guibg=none

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

lua require'lspconfig'.tsserver.setup{ on_attach=require'completion'.on_attach }

set omnifunc="v:lua.vim.lsp.omnifunc"


fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup RUNEWEAVER
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

" ------------
" Key bindings
" ------------

let mapleader = " "

" General
nnoremap <leader>lo :lopen<CR>
nnoremap <leader>lc :lclose<CR>
nnoremap K :lua vim.lsp.buf.hover()<CR>
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" LSP
nnoremap <leader>ca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>cra :lua vim.lsp.buf.range_code_action()<CR>
nnoremap <leader>cf :lua vim.lsp.buf.formatting()<CR>
nnoremap <leader>cr :lua vim.lsp.buf.rename()<CR>

nnoremap <leader>fc :lua vim.lsp.util.create_file()<CR>
nnoremap <leader>fd :lua vim.lsp.util.delete_file()<CR>

nnoremap <leader>gr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>gt :lua vim.lsp.buf.type_definition()<CR>
nnoremap <leader>gdc :lua vim.lsp.buf.declaration()<CR>
nnoremap <leader>gdf :lua vim.lsp.buf.definition()<CR>

"   Diagnostics
nnoremap <leader>dl :lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <leader>dn :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>dp :lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <leader>dcp :lua vim.lsp.diagnostic.get_prev()<CR>
nnoremap <leader>dcn :lua vim.lsp.diagnostic.get_next()<CR>
nnoremap <leader>da :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

" Telescope
nnoremap <leader>tf <cmd>Telescope find_files<CR>
nnoremap <leader>tg <cmd>Telescope live_grep<CR>
nnoremap <leader>tb <cmd>Telescope buffers<CR>
nnoremap <leader>th <cmd>Telescope help_tags<CR>


