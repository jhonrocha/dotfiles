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
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" ripgrep
if executable('rg')
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
  "command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
  command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
  " Rg
	nnoremap <Leader>fa :Find<CR> 
  " Rg current word
  nnoremap <Leader>fw :Rg<space>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"# Plugin: javascript
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" javascript
let g:javascript_enable_domhtmlcss = 1

" vim-javascript
augroup vimrc-javascript
  autocmd!
autocmd FileType javascript setl tabstop=2|setl shiftwidth=2|setl expandtab softtabstop=2
augroup END

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
"# Plugin: indentline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
    set transparency=7
  endif
else
  let g:CSApprox_loaded = 1

  " IndentLine
  let g:indentLine_enabled = 1
  let g:indentLine_concealcursor = 0
  let g:indentLine_char = '┆'
  let g:indentLine_faster = 1

  if $COLORTERM == 'gnome-terminal'
    set term=gnome-256color
  else
    if $TERM == 'xterm'
      set term=xterm-256color
    endif
  endif

endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"# Plugin: Netrw
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_banner = 0
let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"# Git
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Git changes on Quicklist
function! CommitQF(...)
    " Get the commit hash if it was specified
    let commit = a:0 == 0 ? '' : a:1

    " Get the result of git show in a list
    let flist = system('git status -s | cut -d" " -f3')
    let flist = split(flist, '\n')

    " Create the dictionnaries used to populate the quickfix list
    let list = []
    for f in flist
        let dic = {'filename': f, "lnum": 1}
        call add(list, dic)
    endfor

    " Populate the qf list
    call setqflist(list)
    copen
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"# Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching
nnoremap <silent> <leader>ff :Rgrep<CR>

"" Git
noremap <Leader>gs :vertical Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiffsplit!<CR>
noremap <Leader>gj :call CommitQF()<CR>
noremap <Leader>gh :call diffget //2<CR>
noremap <Leader>gl :call diffget //3<CR>
" Gitguttep
nmap <leader>ggp <Plug>(GitGutterPreviewHunk)
nmap <leader>ggs <Plug>(GitGutterStageHunk)
nmap <leader>ggu <Plug>(GitGutterUndoHunk)
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


