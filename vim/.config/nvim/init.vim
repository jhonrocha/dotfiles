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
" Ranger
Plug 'kevinhwang91/rnvimr'
" Nvim Pairs
Plug 'windwp/nvim-autopairs'
" GCC to Comment
Plug 'tpope/vim-commentary'
" Git Integration
Plug 'tpope/vim-fugitive'
" LSP
Plug 'neovim/nvim-lspconfig'
" Completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-path'
Plug 'onsails/lspkind-nvim'
" For vsnip user.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'
" Rust
Plug 'simrat39/rust-tools.nvim'
" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Themes
Plug 'catppuccin/nvim'
Plug 'projekt0n/github-nvim-theme'
" Dashboard
Plug 'glepnir/dashboard-nvim'

" Marks
Plug 'kshenoy/vim-signature'
" WhichKey
Plug 'liuchengxu/vim-which-key'
" Line
Plug 'nvim-lualine/lualine.nvim'
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
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
" Syntax highlight
syntax on
" colorscheme catppuccin
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
set startofline

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
" }}}

">>>....................Autocmd.................... {{{
autocmd GUIEnter * set visualbell t_vb=
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown syntax=markdown
autocmd BufNewFile,BufFilePre,BufRead *.props set filetype=sql syntax=sql
autocmd BufNewFile,BufFilePre,BufRead *.handlebars,*.hbs set filetype=html syntax=handlebars
" }}}

">>>....................SNIPPETS.................... {{{
" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
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

">>>....................DASHBOARD.................... {{{
let g:dashboard_default_executive ='telescope'
let g:dashboard_custom_shortcut={
      \ 'find_file'          : 'SPC SPC',
      \ 'find_history'       : 'SPC f o',
      \ 'new_file'           : 'SPC f n',
      \ 'find_word'          : 'SPC f w',
      \ 'book_marks'         : 'SPC f m',
      \ 'last_session'       : 'SPC s l',
      \ 'change_colorscheme' : 'SPC f t',
      \ }

nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR




let g:dashboard_custom_header = [
      \ '                   ****                                  ****',
      \ '               *********             *    *             *********',
      \ '            ****************        ***  ***        ****************',
      \ '         **************************************************************',
      \ '       ******************************************************************',
      \ '     **********************************************************************',
      \ '    ************************************************************************',
      \ '   ***************************************************************************',
      \ '  *****        **************************************************        ******',
      \ ' ***            ******        ********************        ******            ***',
      \ '**                                ************                                **',
      \ '                                    ********',
      \ '                                     ******',
      \ '                                      ****',
      \ '                                       ** ']

" }}}

">>>....................Load LUA.................... {{{
lua require("config")
" }}}

">>>....................Mappings.................... {{{
"" Opens a tab edit command with the path of the currently edited file filled

nnoremap <silent> <leader><Esc> :noh<cr>

" Last buffer
nnoremap <leader><TAB> <C-^>
let g:which_key_map['TAB'] = 'last buf'

let g:which_key_map.b = [':call ToggleHiddenBar()', 'bar']

nnoremap <silent> <leader>cP :let @+=expand('%:t')<CR>
nnoremap ]j :lua vim.diagnostic.goto_next()<CR>
nnoremap ]k :lua vim.diagnostic.goto_prev()<CR>
" Autofix entire buffer with eslint_d:
nnoremap <leader>cf :call Formatting()<CR>
function! Formatting()
  let s:line=line('.')
  lua vim.lsp.buf.formatting()
  execute s:line
endfunction
let g:which_key_map.c = {
      \ 'name' : '+code' ,
      \ 'D' : [':call v:lua.vim.lsp.buf.declaration()', 'declaration'],
      \ '[' : [':call v:lua.vim.diagnostic.goto_prev()', 'prev error'],
      \ ']' : [':call v:lua.vim.diagnostic.goto_next()', 'next error'],
      \ 'a' : [':call v:lua.vim.lsp.buf.code_action()', 'action'],
      \ 'd' : [':call v:lua.vim.lsp.buf.definition()', 'definition'],
      \ 'i' : [':call v:lua.vim.lsp.buf.implementation()', 'implementation'],
      \ 'f' : [':call Formatting()', 'formatting'],
      \ 'k' : [':call v:lua.vim.lsp.buf.hover()', 'hover'],
      \ 'l' : [':call v:lua.vim.lsp.diagnostic.set_loclist()', 'loclist'],
      \ 'p' : [':let @+=@%', 'cp path'],
      \ 'P' : 'cp file',
      \ 'r' : [':call v:lua.vim.lsp.buf.references()', 'reference'],
      \ 's' : [':call v:lua.vim.lsp.buf.signature_help()', 'help'],
      \ 't' : [':call v:lua.vim.lsp.buf.type_definition()', 'type def'],
      \ 'w' : [':call v:lua.vim.lsp.buf.rename()', 'rename'],
      \ 'Wa' : [':call v:lua.vim.lsp.buf.add_workspace_folder()', 'work add'],
      \ 'Wl' : [':call v:lua.print(vim.inspect(vim.lsp.buf.list_workspace_folders()))', 'work list'],
      \ 'Wr' : [':call v:lua.vim.lsp.buf.remove_workspace_folder()', 'work rm'],
      \ }

nnoremap <leader>d :NvimTreeFindFileToggle<CR>
let g:which_key_map.d = 'tree'

nnoremap <leader>E :e <C-R>=expand("%:p:h") . "/"<CR>
let g:which_key_map.E = 'open file'

let g:which_key_map.e = [':call v:lua.vim.diagnostic.open_float()', 'lsp_line']

nnoremap <leader>gy :!gy<CR><CR>
nnoremap <leader>gk :Git checkout
nnoremap <leader>gp :Git push origin <c-r>=trim(system("git rev-parse --abbrev-ref HEAD"))<CR>
let g:which_key_map.g = {
      \ 'name' : '+Git' ,
      \ 'B' : ['Gblame', 'blame'],
      \ 'c' : ['Git commit', 'commit'],
      \ 'd' : ['Gvdiffsplit!', 'diff'],
      \ 'f' : [':Git pull', 'pull'],
      \ 'g' : [':Git', 'status'],
      \ 'h' : [':call diffget //2', 'diff h'],
      \ 'k' : 'checkout',
      \ 'p' : 'push',
      \ 'v' : [':call diffget //3', 'diff v'],
      \ 'y' : 'yank branch',
      \ }


let g:which_key_map.l = {
      \ 'name' : '+loclist' ,
      \ 'c' : ['lclose', 'close'],
      \ 'l' : ['lopen', 'open'],
      \ 'j' : [':ln', 'l. next'],
      \ 'k' : [':lp', 'l. prev'],
      \ }

nnoremap <leader>p "vp
let g:which_key_map.p = "p bellow"

nnoremap <leader>P "vP
let g:which_key_map.P = "p above"

let g:which_key_map.q = {
      \ 'name' : '+quicklist' ,
      \ 'c' : [':cclose', 'close'],
      \ 'q' : [':copen', 'open'],
      \ 'j' : [':cn', 'quick next'],
      \ 'k' : [':cp', 'quick prev'],
      \ }

let g:which_key_map.r = { 'name' : '+replace' }

nnoremap <leader>rr :%s//gc<left><left><left>
let g:which_key_map.r.r = 'all'

nnoremap <leader>rb :.,$s//gc<left><left><left>
let g:which_key_map.r.b = 'bellow'

" Telescope
let g:which_key_map[' '] = [':call v:lua.ff()', 'T files']
let g:which_key_map[','] = [':Telescope buffers', 'T buffers']
let g:which_key_map.f = {
      \ 'name' : '+Files' ,
      \ 'b' : [':Telescope git_branches', 'branches'],
      \ 'c' : [':Telescope git_commits', 'commits'],
      \ 'd' : ['bd', 'delete'],
      \ 'f' : ['RnvimrToggle', 'manager'],
      \ 'h' : [':Telescope help_tags', 'help'],
      \ 'm' : [':Telescope marks', 'marks'],
      \ 'k' : ['bd', 'close'],
      \ 'o' : [':Telescope oldfiles', 'prev files'],
      \ 's' : ['update', 'save'],
      \ 't' : [':Telescope colorscheme', 'theme'],
      \ 'w' : [':Telescope live_grep', 'grep'],
      \ 'x' : [':Telescope commands', 'commands'],
      \ 'y' : [':Telescope command_history', 'com. history'],
      \ }

let g:which_key_map.j = ['bn', 'next buf']
let g:which_key_map.k = ['bp', 'prev buf']

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
