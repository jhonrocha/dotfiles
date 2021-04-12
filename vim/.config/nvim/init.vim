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
" Git Integration
Plug 'tpope/vim-fugitive'
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
" WhichKey
Plug 'liuchengxu/vim-which-key'
" Terminal
Plug 'voldikss/vim-floaterm'
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
  let g:fzf_colors = { 'bg': ['bg', 'Normal'] }
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

">>>....................Which Key.................... {{{
" call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
" Define prefix dictionary
let g:which_key_map =  {}
" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler
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
hi NvimTreeFolderIcon guifg=#61afef
hi NvimTreeFolderName guifg=#61afef
let g:nvim_tree_hijack_netrw = 1
let g:nvim_tree_disable_netrw = 0
let g:nvim_tree_quit_on_open = 1
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
" }}}

">>>....................Git.................... {{{
"" Git
" }}}

">>>....................Mappings.................... {{{
"" Opens a tab edit command with the path of the currently edited file filled

nnoremap <silent> <leader><Esc> :noh<cr>
let g:which_key_map[' '] = [ 'Files' , 'files' ]
let g:which_key_map[','] = [ 'Buffers' , 'buffers' ]

let g:which_key_map.b = {
      \ 'name' : '+buffer' ,
      \ 'd' : ['bd', 'delete'],
      \ 'k' : ['bp | bd #', 'close'],
      \ 'n' : ['bn' , 'next'],
      \ 'p' : ['bp' , 'prev'],
      \ }

let g:which_key_map.B = [':call ToggleHiddenBar()', 'bar']

let g:which_key_map.c = {
      \ 'name' : '+code' ,
      \ 'D' : [':lua vim.lsp.buf.declaration()', 'declaration'],
      \ '[' : [':lua vim.lsp.diagnostic.goto_prev()', 'prev error'],
      \ ']' : [':lua vim.lsp.diagnostic.goto_next()', 'next error'],
      \ 'c' : [':lua vim.lsp.buf.rename()', 'rename'],
      \ 'd' : [':lua vim.lsp.buf.definition()', 'definition'],
      \ 'e' : [':lua vim.lsp.diagnostic.show_line_diagnostics()', 'show'],
      \ 'i' : [':lua vim.lsp.buf.implementation()', 'implementation'],
      \ 'k' : [':lua vim.lsp.buf.hover()', 'hover'],
      \ 'l' : [':lua vim.lsp.diagnostic.set_loclist()', 'loclist'],
      \ 'p' : [':let @+=@%', 'cp path'],
      \ 'r' : [':lua vim.lsp.buf.references()', 'reference'],
      \ 's' : [':lua vim.lsp.buf.signature_help()', 'help'],
      \ 't' : [':lua vim.lsp.buf.type_definition()', 'type def'],
      \ 'wa' : [':lua vim.lsp.buf.add_workspace_folder()', 'work add'],
      \ 'wl' : [':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))', 'work list'],
      \ 'wr' : [':lua vim.lsp.buf.remove_workspace_folder()', 'work rm'],
      \ }

let g:which_key_map.d = ['NvimTreeFindFile', 'tree']

nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/"<CR>
let g:which_key_map.e = 'open file'

let g:which_key_map.f = {
      \ 'name' : '+Fuzzy' ,
        \ ',' : [':call v:lua.my_buffers()', 'T buffers'],
        \ 'c' : [':Commits', 'commits'],
        \ 'f' : [':Rg', 'find word'],
        \ 'h' : [':Telescope help_tags', 'T Help'],
        \ 'H' : [':History', 'history'],
        \ 'o' : [':call v:lua.require("telescope.builtin").oldfiles()', 'T oldfiles'],
        \ 't' : [':call v:lua.my_find_files()', 'T files'],
        \ 'w' : [':Telescope live_grep', 'T live grep'],
        \ 'x' : [':Commands', 'commands'],
      \ }

let g:which_key_map.g = {
      \ 'name' : '+Git' ,
        \ 'b' : [':Gblame', 'blame'],
        \ 'c' : [':Git commit', 'commit'],
        \ 'd' : [':Gvdiffsplit!', 'diff'],
        \ 'f' : [':Git pull', 'pull'],
        \ 'g' : [':tab Gstatus', 'status'],
        \ 'h' : [':call diffget //2', 'diff h'],
        \ 'k' : [':Git checkout', 'checkout'],
        \ 'l' : [':call diffget //3', 'diff v'],
        \ 'y' : [':!gy', 'yank branch'],
      \ }

nnoremap <leader>gp :Git push origin <c-r>=trim(system("git rev-parse --abbrev-ref HEAD"))<CR>
let g:which_key_map.g.p = "push"

let g:which_key_map.l = {
      \ 'name' : '+loclist' ,
      \ 'c' : [':lclose', 'close'],
      \ 'o' : [':lopen', 'open'],
      \ }
let g:which_key_map.i = [':lnext', 'loc next']
let g:which_key_map.u = [':lprevious', 'loc prev']

nnoremap <leader>p "vp
let g:which_key_map.p = "p bellow"

nnoremap <leader>P "vP
let g:which_key_map.P = "p above"

let g:which_key_map.q = {
      \ 'name' : '+quicklist' ,
      \ 'c' : [':cclose', 'close'],
      \ 'o' : [':copen', 'open'],
      \ }
let g:which_key_map.j = [':cn', 'quick next']
let g:which_key_map.k = [':cp', 'quick prev']

let g:which_key_map.r = { 'name' : '+replace' }

nnoremap <leader>rr :%s//gc<left><left><left>
let g:which_key_map.r.r = 'all'

nnoremap <leader>rb :.,$s//gc<left><left><left>
let g:which_key_map.r.b = 'bellow'

let g:which_key_map.s = ['/', '/']



" Expand location
cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

"" Buffer nav


"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" Closing
nnoremap <silent> <C-x><C-q> :qa<CR>
" Close the current buffer and move to the previous one
nmap <C-x><C-s> :update<CR>

" Copy Path

" Moving deletions to register 'v'
nnoremap d "vd
nnoremap D "vD
nnoremap x "vx
nnoremap X "vX
nnoremap c "vc
nnoremap C "vC
nnoremap s "vs
nnoremap S "vS

" Search and Replace global

" Quicklist
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
" Integration
" TMUX: Ranger
nmap <silent> <C-x><C-j> :!tmux new-window -a "ranger" -c <C-R>=expand("%:p:h")<CR><CR><CR>

call which_key#register('<Space>', "g:which_key_map")
" }}}
