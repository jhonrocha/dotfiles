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
" ViFM
Plug 'vifm/vifm.vim'
" Vim Surround
Plug 'tpope/vim-surround'
" GCC to Comment
Plug 'tpope/vim-commentary'
" Git Integration
Plug 'tpope/vim-fugitive'
" LSP
Plug 'neovim/nvim-lspconfig'
" Completion
Plug 'hrsh7th/nvim-compe'
" Floaterm
Plug 'voldikss/vim-floaterm'
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
Plug 'rakr/vim-one'
Plug 'phanviet/vim-monokai-pro'
Plug 'chriskempson/base16-vim'
" Distraction Free
Plug 'junegunn/goyo.vim'
" Marks
Plug 'kshenoy/vim-signature'
" WhichKey
Plug 'liuchengxu/vim-which-key'
" Line
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
call plug#end()
" }}}

">>>....................Basic Setup.................... {{{
" Remove mapped space
nnoremap <Space> <Nop>
nnoremap <silent> <F11> :Goyo<CR>
" Set space as leader
let mapleader=" "
" Relative and global linenumbers
set number relativenumber
" True Colors
set termguicolors
" Time to wait mapped input
set timeoutlen=500
" Enable hidden buffers
set hidden
" Updating swap file interval
set updatetime=1000
" Merge signcolumn and number column into one
set signcolumn=auto:1
" Completion
set completeopt=menuone,noinsert,noselect
" Theme Setting
function! s:patch_theme_colors()
  " hi! Normal ctermbg=NONE guibg=NONE
  " hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
  " hi! SignColor ctermbg=NONE guibg=NONE 
  " hi! LineNr ctermbg=NONE guibg=NONE
  hi! statusline guifg=#202328 guibg=#202328 ctermfg=black ctermbg=cyan
  let g:fzf_colors = { 'bg': ['bg', 'Normal'] }
endfunction
autocmd! ColorScheme * call s:patch_theme_colors()
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
" Syntax highlight
syntax on
colorscheme one
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
set wrap linebreak
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

">>>....................Floaterm.................... {{{
let g:floaterm_autoclose = 1
let g:floaterm_keymap_toggle = '<C-t>'
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
let g:floaterm_opener = 'edit'
hi FloatermBorder guibg=NONE guifg=cyan
" }}}

">>>....................LSP.................... {{{
sign define LspDiagnosticsSignError text=. texthl=LspDiagnosticsSignError linehl= numhl=
sign define LspDiagnosticsSignWarning text=. texthl=LspDiagnosticsSignWarning linehl= numhl=
sign define LspDiagnosticsSignInformation text=. texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint text=.  texthl=LspDiagnosticsSignHint linehl= numhl=
hi LspDiagnosticsUnderlineError cterm=undercurl gui=undercurl guisp=#fb4934
hi LspDiagnosticsUnderlineWarning cterm=undercurl gui=undercurl guisp=#fabd2f
hi LspDiagnosticsUnderlineInformation cterm=undercurl gui=undercurl guisp=#83a598
hi LspDiagnosticsUnderlineHint cterm=undercurl gui=undercurl guisp=#8ec07c
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

">>>....................Terminal.................... {{{
autocmd TermOpen term://* startinsert
" }}}

">>>....................Goyo.................... {{{
let g:goyo_width=70
let g:goyo_height=70
" let g:goyo_linenr=70
lua require('galaxyline').load_galaxyline()
function! s:goyo_enter()
  set laststatus=0
  lua vim.defer_fn(require("galaxyline").disable_galaxyline, 10)
endfunction

function! s:goyo_leave()
  lua require('galaxyline').load_galaxyline()
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
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

">>>....................Mappings.................... {{{
"" Opens a tab edit command with the path of the currently edited file filled

nnoremap <silent> <leader><Esc> :noh<cr>
let g:which_key_map[' '] = [ 'Files' , 'files' ]
let g:which_key_map[','] = [ 'Buffers' , 'buffers' ]

" Last buffer
nnoremap <leader><TAB> <C-^>
let g:which_key_map['TAB'] = 'last buf'
nnoremap <silent> <leader>. :Files <c-r>=expand("%:p:h") . "/"<cr><cr>
let g:which_key_map['.'] = '. files'

let g:which_key_map.b = [':call ToggleHiddenBar()', 'bar']

nnoremap <silent> <leader>cP :let @+=expand('%:t')<CR>
nnoremap ]j :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap ]k :lua vim.lsp.diagnostic.goto_prev()<CR>
let g:which_key_map.c = {
      \ 'name' : '+code' ,
      \ 'D' : [':call v:lua.vim.lsp.buf.declaration()', 'declaration'],
      \ '[' : [':call v:lua.vim.lsp.diagnostic.goto_prev()', 'prev error'],
      \ ']' : [':call v:lua.vim.lsp.diagnostic.goto_next()', 'next error'],
      \ 'c' : [':call v:lua.vim.lsp.buf.rename()', 'rename'],
      \ 'd' : [':call v:lua.vim.lsp.buf.definition()', 'definition'],
      \ 'e' : [':call v:lua.vim.lsp.diagnostic.show_line_diagnostics()', 'show'],
      \ 'i' : [':call v:lua.vim.lsp.buf.implementation()', 'implementation'],
      \ 'k' : [':call v:lua.vim.lsp.buf.hover()', 'hover'],
      \ 'l' : [':call v:lua.vim.lsp.diagnostic.set_loclist()', 'loclist'],
      \ 'p' : [':let @+=@%', 'cp path'],
      \ 'P' : 'cp file',
      \ 'r' : [':call v:lua.vim.lsp.buf.references()', 'reference'],
      \ 's' : [':call v:lua.vim.lsp.buf.signature_help()', 'help'],
      \ 't' : [':call v:lua.vim.lsp.buf.type_definition()', 'type def'],
      \ 'wa' : [':call v:lua.vim.lsp.buf.add_workspace_folder()', 'work add'],
      \ 'wl' : [':call v:lua.print(vim.inspect(vim.lsp.buf.list_workspace_folders()))', 'work list'],
      \ 'wr' : [':call v:lua.vim.lsp.buf.remove_workspace_folder()', 'work rm'],
      \ }

let g:which_key_map.d = ['NvimTreeFindFile', 'tree']

nnoremap <leader>E :e <C-R>=expand("%:p:h") . "/"<CR>
let g:which_key_map.E = 'open file'

let g:which_key_map.e = [':call v:lua.vim.lsp.diagnostic.show_line_diagnostics()', 'lsp_line']

let g:which_key_map.f = {
      \ 'name' : '+files' ,
      \ 'd' : ['bd', 'delete'],
      \ 'f' : ['Vifm', 'Vifm'],
      \ 'k' : [':bp | bd #', 'close'],
      \ 'n' : ['bn' , 'next'],
      \ 'p' : ['bp' , 'prev'],
      \ 's' : ['update', 'save'],
      \ }

nnoremap <leader>gy :!gy<CR><CR>
nnoremap <leader>gk :Git checkout
let g:which_key_map.g = {
      \ 'name' : '+Git' ,
      \ 'b' : [':FloatermNew gb', 'branch'],
      \ 'B' : ['Gblame', 'blame'],
      \ 'c' : ['Git commit', 'commit'],
      \ 'd' : ['Gvdiffsplit!', 'diff'],
      \ 'f' : [':Git pull', 'pull'],
      \ 'g' : [':tab Git', 'status'],
      \ 'h' : [':call diffget //2', 'diff h'],
      \ 'k' : 'checkout',
      \ 'v' : [':call diffget //3', 'diff v'],
      \ 'y' : 'yank branch',
      \ }

nnoremap <leader>gp :Git push origin <c-r>=trim(system("git rev-parse --abbrev-ref HEAD"))<CR>
let g:which_key_map.g.p = "push"

let g:which_key_map.l = {
      \ 'name' : '+loclist' ,
      \ 'c' : ['lclose', 'close'],
      \ 'l' : ['lopen', 'open'],
      \ }
let g:which_key_map.i = ['lnext', 'loc next']
let g:which_key_map.u = ['lprevious', 'loc prev']

nnoremap <leader>p "vp
let g:which_key_map.p = "p bellow"

nnoremap <leader>P "vP
let g:which_key_map.P = "p above"

let g:which_key_map.q = {
      \ 'name' : '+quicklist' ,
      \ 'c' : [':cclose', 'close'],
      \ 'q' : [':copen', 'open'],
      \ }
let g:which_key_map.j = [':cn', 'quick next']
let g:which_key_map.k = [':cp', 'quick prev']

let g:which_key_map.r = { 'name' : '+replace' }

nnoremap <leader>rr :%s//gc<left><left><left>
let g:which_key_map.r.r = 'all'

nnoremap <leader>rb :.,$s//gc<left><left><left>
let g:which_key_map.r.b = 'bellow'

let g:which_key_map.s = {
      \ 'name' : '+Fuzzy' ,
      \ ',' : [':call v:lua.my_buffers()', 'T buffers'],
      \ 'c' : [':Commits', 'commits'],
      \ 'f' : [':Rg', 'grep'],
      \ 'h' : [':Telescope help_tags', 'T Help'],
      \ 'H' : [':History', 'history'],
      \ 'o' : [':call v:lua.require("telescope.builtin").oldfiles()', 'T oldfiles'],
      \ 's' : ['/', '/'],
      \ 't' : [':call v:lua.my_find_files()', 'T files'],
      \ 'w' : [':Telescope live_grep', 'T grep'],
      \ 'x' : [':Commands', 'commands'],
      \ }

let g:which_key_map.x = {
      \ 'name' : '+M-x' ,
      \ 'k' : ['update', 'save'],
      \ 'g' : ['Goyo', 'Goyo'],
    \ }

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
" nnoremap <silent> <C-x><C-q> :qa<CR>
" Close the current buffer and move to the previous one
" nmap <C-x><C-s> :update<CR>

" Moving deletions to register 'v'
nnoremap d "vd
nnoremap D "vD
nnoremap x "vx
nnoremap X "vX
nnoremap c "vc
nnoremap C "vC
nnoremap s "vs
nnoremap S "vS

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
call which_key#register('<Space>', "g:which_key_map")
" }}}
