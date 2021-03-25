"" Include user's extra bundle
" if filereadable(expand("~/.vimrc"))
  " source ~/.vimrc
" endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"# Plug For Managing Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('nvim')
  let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
else
  let vimplug_exists=expand('~/.vim/autoload/plug.vim')
endif

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"
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
" Use RipGrep and others
Plug 'vim-scripts/grep.vim'
" Snippets
Plug 'honza/vim-snippets'
" Languages Support
Plug 'sheerun/vim-polyglot'
" Show Marks
Plug 'kshenoy/vim-signature'
" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Distraction Free
Plug 'junegunn/goyo.vim'
" Vimwiki
Plug 'vimwiki/vimwiki'
" Themes
Plug 'dracula/vim', { 'name': 'dracula' }
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
" Line
Plug 'itchyny/lightline.vim'
call plug#end()

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

" Theme Setting
" function! s:patch_theme_colors()
"   hi! Normal ctermbg=NONE guibg=NONE
"   hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
"   set background=dark
" endfunction
" autocmd! ColorScheme * call s:patch_theme_colors()
colorscheme molokai
let g:lightline = { 'colorscheme': 'wombat' }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File Types
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown syntax=markdown
autocmd BufNewFile,BufFilePre,BufRead *.props set filetype=sql syntax=sql

" Extensions
let g:coc_global_extensions = [
      \'coc-eslint',
      \'coc-json',
      \'coc-markdownlint',
      \'coc-pairs',
      \'coc-python',
      \'coc-rls',
      \'coc-snippets',
      \'coc-tsserver', 
      \'coc-vimlsp',
      \]

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
				\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{'path': '~/org/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
" NERDTree Configs
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:NERDTreeWinSize = 50
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"# Basic Setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" On pressing tab, insert 2 spaces
set expandtab
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2

" Enable hidden buffers
set hidden

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

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
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamedplus
endif

"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=20
augroup END

" Setting directory for swap files
set directory^=$HOME/.vim/tmp//

" Highlight Cursor Position
set cursorline
"set cursorcolumn

" Stop Adding Comments
set formatoptions-=r formatoptions-=c formatoptions-=o formatoptions+=t 

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
"# Grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Wildignore
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

" grep.vim
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

" Tagbar
let g:tagbar_autofocus = 1

"" fzf.vim
let g:fzf_layout = { 'down': '50%' }
" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
  "command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
  command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
  " Rg
	nnoremap <Leader>fa :Find<CR> 
  " Rg current word
  nnoremap <Leader>fw :Rg<space>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"# Plugin: ALE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE Configuration
let g:ale_fixers = {
 \ 'javascript': ['eslint']
 \ }

let g:ale_linters = {
\   'javascript': ['eslint']
\}

let g:ale_sign_error = 'X'
let g:ale_sign_warning = '!'
let g:ale_fix_on_save = 0
let g:ale_completion_enabled = 1
" set completeopt=menu,menuone,preview,noselect,noinsert

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"# Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching
nnoremap <silent> <leader>ff :Rgrep<CR>

"" Git
noremap <Leader>gg :tab Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiffsplit!<CR>
noremap <Leader>gj :call CommitQF()<CR>
noremap <Leader>gh :call diffget //2<CR>
noremap <Leader>gl :call diffget //3<CR>
"" Open current line on GitHub
nnoremap <Leader>go :.Gbrowse<CR>
nnoremap <Leader>gx :!gx<CR><CR>

"" Set working directory
" nnoremap <leader>. :lcd %:p:h<CR>

"" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Expand location
cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Tagbar
nmap <silent> <Leader>tg :TagbarToggle<CR>

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
nnoremap <silent> ZA :qa<CR>
nnoremap <silent> ZS :wqa<CR>
nnoremap <silent> ZT :tabclose<CR>

" Copy filename
noremap <leader>mv :vimgrep<space>

" Moving deletions to register 'a'
nnoremap d "vd
nnoremap D "vD
nnoremap x "vx
nnoremap X "vX
nnoremap c "vc
nnoremap C "vC
nnoremap s "vs
nnoremap S "vS
noremap <leader>p "vp
noremap <leader>P "vP

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
" List cwd files
nnoremap <silent> <leader><Space> :FZF -m --no-preview<CR>
" Last buffer
nnoremap <leader><TAB> <C-^>
nnoremap <A-TAB> <C-^>
" List open buffers
nnoremap <silent> <leader>, :Buffers<CR>
" List locals files
noremap <silent> <Leader>. :FZF <C-R>=expand("%:p:h") . "/"<CR><CR>

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

" ------------------------------
" PLUGIN'S MAPS
" ------------------------------
" COC
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <silent> <space>ca  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>ce  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>cc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>co  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>cs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>cj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>ck  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>cp  :<C-u>CocListResume<CR>

" NERDTree
noremap <silent> <leader>e :NERDTreeFind<CR>
noremap <silent> <leader>d :NERDTreeToggle<CR>

" FZF
"Recovery commands from history through FZF
nmap <leader>R :History:<CR>
nmap <A-x> :Commands<CR>
