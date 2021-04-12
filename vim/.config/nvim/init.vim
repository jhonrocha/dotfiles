" vim:fileencoding=utf-8:foldmethod=marker

">>>....................Plug For Managing Plugins.................... {{{
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vimplug_exists)
  echo "Installing Vim-Plug..."
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall
endif
" }}}

">>>....................Plugins.................... {{{
call plug#begin(expand('~/.vim/plugged'))
"File Drawer
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
" Vim Surround
Plug 'tpope/vim-surround'
" GCC to Comment
Plug 'tpope/vim-commentary'
" Auto Pairs
Plug 'jiangmiao/auto-pairs'
" Git Integration
Plug 'tpope/vim-fugitive'
" Indent Line
" Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua'}
" LSP
Plug 'neovim/nvim-lspconfig'
" Completion
Plug 'hrsh7th/nvim-compe'
" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Completion
Plug 'hrsh7th/nvim-compe'
" Themes
Plug 'gruvbox-community/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'tomasr/molokai'
" Line
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
call plug#end()
" }}}

">>>....................Basic Setup.................... {{{
" Remove mapped space
nnoremap <Space> <Nop>
" Set space as leader
let mapleader=" "
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
set signcolumn=number
" Completion
set completeopt=menuone,noinsert,noselect
" Theme Setting
function! s:patch_theme_colors()
  hi! Normal ctermbg=NONE guibg=NONE
  hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
  hi! SignColor ctermbg=NONE guibg=NONE 
  hi! LineNr ctermbg=NONE guibg=NONE
endfunction
autocmd! ColorScheme * call s:patch_theme_colors()
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
" Syntax highlight
syntax on
colorscheme gruvbox
" let g:lightline = { 'colorscheme': 'molokai' }

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
" }}}

">>>....................Visual Settings.................... {{{
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
" }}}

">>>....................Autocmd.................... {{{
autocmd GUIEnter * set visualbell t_vb=
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown syntax=markdown
autocmd BufNewFile,BufFilePre,BufRead *.props set filetype=sql syntax=sql
autocmd BufNewFile,BufFilePre,BufRead *.handlebars,*.hbs set filetype=html syntax=handlebars
" }}}

">>>....................LSP.................... {{{
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
nnoremap <leader>ll :lua vim.lsp.diagnostic.set_loclist()<CR>
" }}}

">>>....................COMPE.................... {{{
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
" }}}

">>>....................Tree.................... {{{
let g:nvim_tree_indent_markers = 1
noremap <silent> <leader>d :NvimTreeFindFile<CR>
hi NvimTreeFolderIcon guifg=#61afef
hi NvimTreeFolderName guifg=#61afef
" }}}

">>>....................IndentLine.................... {{{
" hi IndentBlanklineChar guifg=#373b43
" let g:indentLine_char = '┊'
" }}}

">>>....................Abbreviations.................... {{{
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
" }}}

">>>....................Telescope.................... {{{
" " Find files using Telescope command-line sugar.
nnoremap <leader>tt <cmd>lua my_find_files()<cr>
nnoremap <leader>tf <cmd>Telescope live_grep<cr>
nnoremap <leader>t, <cmd>lua my_buffers()<cr>
nnoremap <leader>th <cmd>Telescope help_tags<cr>
nnoremap <leader>to <cmd>lua require('telescope.builtin').oldfiles()<cr>
" }}}

">>>....................FZF.................... {{{
let g:fzf_buffers_jump = 1
let g:fzf_colors = { 'bg': ['bg', 'Normal'] }

" This is the default extra key bindings
" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --hidden --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
nnoremap <silent> <leader><space> :Files<cr>
nnoremap <silent> <leader>. :Files <c-r>=expand("%:p:h") . "/"<cr><cr>
nnoremap <silent> <leader>, :Buffers<cr>
nnoremap <silent> <leader>: :Commands<cr>
nnoremap <silent> <A-x> :Commands<cr>
nnoremap <silent> <leader>fc :Commits<cr>
nnoremap <silent> <leader>fh :History<cr>
nnoremap <silent> <leader>ff :Rg<cr>
" }}}

">>>....................Git.................... {{{
"" Git
noremap <Leader>gg <cmd>tab Gstatus<CR>
noremap <Leader>gf <cmd>Git pull<CR>
noremap <Leader>gp :Git push origin <c-r>=trim(system('git rev-parse --abbrev-ref HEAD'))<CR>
noremap <Leader>gc <cmd>Git commit<CR>
noremap <Leader>gh <cmd>Git checkout
noremap <Leader>gB <cmd>Gblame<CR>
noremap <Leader>gc <cmd>Git commit<CR>
noremap <Leader>gds <cmd>Gvdiffsplit!<CR>
noremap <Leader>gdh <cmd>call diffget //2<CR>
noremap <Leader>gdl <cmd>call diffget //3<CR>
noremap <Leader>gy <cmd>!gy<CR><CR>
" }}}

">>>....................Mappings.................... {{{
"" Opens a tab edit command with the path of the currently edited file filled

" Expand location
cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
noremap <Leader>E :e <C-R>=expand("%:p:h") . "/" <CR>

"" Buffer nav
noremap <leader>bp :bp<CR>
noremap <leader>bn :bn<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><Esc> :noh<cr>

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" Closing
nnoremap <silent> <C-x><C-q> :qa<CR>
" Close the current buffer and move to the previous one
noremap <leader>xk :bd<CR>
noremap <leader>bk :bp <BAR> bd #<CR>
nmap <C-x><C-s> :update<CR>

" Copy Path
noremap <silent><leader>cp :let @+=@%<CR>

" Moving deletions to register 'v'
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
noremap <leader>qc :cclose<CR>
noremap <leader>j :cn<CR>
noremap <leader>k :cp<CR>
" Locallist
noremap <leader>lo :lopen<CR>
noremap <leader>lc :lclose<CR>
noremap <leader>u :lprevious<CR>
noremap <leader>i :lnext<CR>

" Easier search
noremap <leader>s /
" Last buffer
nnoremap <A-TAB> <C-^>

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
" Integration
" TMUX: Ranger
nmap <silent> <C-x><C-j> :!tmux new-window -a "ranger" -c <C-R>=expand("%:p:h")<CR><CR><CR>
" }}}
