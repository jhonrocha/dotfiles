"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"# Plug For Managing Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vimplug_exists)
  echo "Installing Vim-Plug..."
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall
endif

"# Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin(expand('~/.vim/plugged'))
" NERDTree
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
" Vim Surround
Plug 'tpope/vim-surround'
" GCC to Comment
Plug 'tpope/vim-commentary'
" Git Integration
Plug 'tpope/vim-fugitive'
" Completion
Plug 'neovim/nvim-lspconfig'
" Completion
Plug 'hrsh7th/nvim-compe'
" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
" Themes
Plug 'dracula/vim', { 'name': 'dracula' }
Plug 'joshdick/onedark.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'tomasr/molokai'
" Line
Plug 'itchyny/lightline.vim'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"# Basic Setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove mapped space
nnoremap <Space> <Nop>
" Set space as leader
let mapleader=" "
" Syntax highlight
syntax on
" Relative and global linenumbers
set number relativenumber
" True Colors
set termguicolors
" Time to wait mapped input
set timeoutlen=1000
" Enable hidden buffers
set hidden
" Updating swap file interval
set updatetime=1000
" Merge signcolumn and number column into one
set signcolumn=yes
" Completion
set completeopt=menuone,noinsert,noselect
" Theme Setting
" function! s:patch_theme_colors()
" endfunction
" autocmd! ColorScheme * call s:patch_theme_colors()
colorscheme gruvbox
set background=dark
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
let g:lightline = { 'colorscheme': 'wombat' }

" Turn on for plugin management
filetype plugin indent on
" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
" Fast scrool
set ttyfast
" Wrapping
set wrap
set linebreak
set nolist
set path+=**
" Fix backspace indent
set backspace=indent,eol,start
" No Backup
set nobackup
set nowritebackup
set undodir=~/.cache/.vimdid
set undofile
" Tabs. May be overridden by autocmd rules
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
" Shell setting
if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

" Split direction
set autoread
set splitright

" sessionoptionsn
set sessionoptions=blank,buffers,curdir,folds,help,options,tabpages,winsize

" Disable visualbell
set noerrorbells visualbell t_vb=

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamedplus
endif

" Setting directory for swap files
set directory^=$HOME/.vim/tmp//
" Highlight Cursor Position
set cursorline
" Stop Adding Comments
set formatoptions-=r formatoptions-=c formatoptions-=o formatoptions+=t 
" Wildignore
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"# Visual Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if &term =~ '256color'
  set t_ut=
endif
" Mouse Configuration
set mouse=a
set mousemodel=popup

set t_Co=256
set guioptions=egmrti
set gfn=Monospace\ 10


"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

"" Use modeline overrides
set modeline
set modelines=10
set modelineexpr

set title
set titleold="Terminal"
set titlestring=%F
" Lua Configs
lua require("config")

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocmd
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd GUIEnter * set visualbell t_vb=
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown syntax=markdown
autocmd BufNewFile,BufFilePre,BufRead *.props set filetype=sql syntax=sql

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LSP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap gD :lua vim.lsp.buf.declaration()<CR>
nnoremap gd :lua vim.lsp.buf.definition()<CR>
nnoremap gr :lua vim.lsp.buf.references()<CR>
nnoremap gi :lua vim.lsp.buf.implementation()<CR>
nnoremap K :lua vim.lsp.buf.hover()<CR>
nnoremap <C-k> :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>wa :lua vim.lsp.buf.add_workspace_folder()<CR>
nnoremap <leader>wr :lua vim.lsp.buf.remove_workspace_folder()<CR>
nnoremap <leader>wl :lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
nnoremap <leader>D :lua vim.lsp.buf.type_definition()<CR>
nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>e :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap [e :lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap ]e :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>q :lua vim.lsp.diagnostic.set_loclist()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COMPE
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTREE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:NERDTreeWinSize = 50
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1

" NERDTree
noremap <silent> <leader>D :NERDTreeFind<CR>
noremap <silent> <leader>d :NERDTreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"# Abbreviations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"# TELESCOPE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " List cwd files
" nnoremap <silent> <leader><Space> :FZF -m --no-preview<CR>
nnoremap <leader>pg :lua require('telescope.builtin').git_files()<CR>
nnoremap <leader><space> :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
" nnoremap <silent> <Leader><space> :lua require('telescope.builtin').find_files({ find_command = {"rg","--hidden","--color=never","--no-heading","--with-filename","--ignore","--files"}})<CR><CR>
" nnoremap <silent> <Leader><space> :lua require('telescope.builtin').find_files({ find_command = {"fd"} })<CR>
nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>, :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>pt :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>pb :lua require('telescope.builtin').git_branches()<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"# Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Git
noremap <Leader>gg :tab Gstatus<CR>
noremap <Leader>gf :Git pull<CR>
noremap <Leader>gp :Git push<CR>
noremap <Leader>gc :Git commit<CR>
noremap <Leader>gb :Git checkout<CR>
noremap <Leader>gB :Gblame<CR>
noremap <Leader>gd :Gvdiffsplit!<CR>
noremap <Leader>gh :call diffget //2<CR>
noremap <Leader>gl :call diffget //3<CR>

"" Opens a tab edit command with the path of the currently edited file filled
" noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Expand location
cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Copying on mac
if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

"" Buffer nav
noremap <leader>u :bp<CR>
noremap <leader>i :bn<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><Esc> :noh<cr>

" Zooming
noremap ZI <c-w>_ \| <c-w>\|
noremap ZO <c-w>=

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Mapping Shortcupts
nnoremap <silent> <C-q> :qa<CR>
nnoremap <silent> ZA :qa<CR>
nnoremap <silent> ZS :wqa<CR>
nnoremap <silent> ZT :tabclose<CR>
" Moving deletions to register 'a'
nnoremap d "vd
nnoremap D "vD
nnoremap x "vx
nnoremap X "vX
nnoremap c "vc
nnoremap C "vC
nnoremap s "vs
nnoremap S "vS
noremap <leader>vp "vp
noremap <leader>vP "vP

" Search and Replace global
nnoremap <leader>rr :%s//gc<left><left><left>
nnoremap <leader>rb :.,$s//gc<left><left><left>

" Quicklist
noremap <leader>qo :copen<CR>
noremap <leader>qn :cn<CR>
noremap <leader>qp :cp<CR>
noremap <leader>qc :ccl<CR>


" Easier search
noremap <leader>s /
" Last buffer
nnoremap <leader><TAB> <C-^>
nnoremap <A-TAB> <C-^>
" Close the current buffer and move to the previous one
noremap <leader>xk :bd<CR>
noremap <leader>fq :bp <BAR> bd #<CR>
nmap <C-x><C-s> :update<CR>

" File path copy
noremap <silent><leader>fp :let @+=@%<CR>
" Theme Binding
map <F11> :Goyo<CR>

" Functions
let s:hidden_bar = 0
function! ToggleHiddenBar()
    if s:hidden_bar  == 0
        let s:hidden_bar = 1
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_bar = 0
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction
nnoremap <leader>bb :call ToggleHiddenBar()<CR>


nmap <silent> <C-x><C-j> :!tmux new-window -a "ranger" -c <C-R>=expand("%:p:h")<CR><CR><CR>
