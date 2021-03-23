" Remove mapped space
nnoremap <Space> <Nop>
let mapleader=" "

syntax on                                 " Turn On syntax
set number relativenumber                 " Relative and global linenumbers
set termguicolors                         " True Colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"    " Fix Termguicolors
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"    " Fix Termguicolors
set timeoutlen=500                        " Time till stop waiting
" set noshowmode                            " Hide Mode line
" set noruler                               " Hide ruler for cursor position
" set laststatus=0                          " Never show another status


set hidden                                " Enable hidden buffers
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Theme Setting
function! s:patch_theme_colors()
  hi! Normal ctermbg=NONE guibg=NONE
  hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
  set background=dark
endfunction
autocmd! ColorScheme * call s:patch_theme_colors()

colorscheme dracula


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AutoCommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown syntax=markdown
autocmd BufNewFile,BufFilePre,BufRead *.props set filetype=sql syntax=sql

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" status bar colors
au InsertEnter * hi statusline guifg=black guibg=#d7afff ctermfg=black ctermbg=magenta
au InsertLeave * hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan
hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan

" Status Line Custom
let g:currentmode={
    \ 'n'     : 'NORMAL',
    \ 'no'    : 'NORMAL·OPERATOR PENDING',
    \ 'v'     : 'VISUAL',
    \ 'V'     : 'V·LINE',
    \ '^V'    : 'V·BLOCK',
    \ "\<C-V>": 'V·BLOCK',
    \ 's'     : 'SELECT',
    \ 'S'     : 'S·LINE',
    \ '^S'    : 'S·BLOCK',
    \ 'i'     : 'INSERT',
    \ 'R'     : 'REPLACE',
    \ 'Rv'    : 'V·REPLACE',
    \ 'c'     : 'COMMAND',
    \ 'cv'    : 'VIM EX',
    \ 'ce'    : 'EX',
    \ 'r'     : 'PROMPT',
    \ 'rm'    : 'MORE',
    \ 'r?'    : 'CONFIRM',
    \ '!'     : 'SHELL',
    \ 't'     : 'TERMINAL'
    \}

set statusline=
set statusline+=%0*\ %{g:currentmode[mode()]}\           " The current mode
set statusline+=%1*\ %<%f%m%r%h%w\                       " File path, modified, readonly, helpfile, preview
set statusline+=%3*│                                     " Separator
set statusline+=%2*\ %Y\                                 " FileType
set statusline+=%3*│                                     " Separator
set statusline+=%2*\ %{''.(&fenc!=''?&fenc:&enc).''}     " Encoding
set statusline+=\ (%{&ff})                               " FileFormat (dos/unix..)
set statusline+=%=                                       " Right Side
set statusline+=%2*\ col:\ %02v\                         " Colomn number
set statusline+=%3*│                                     " Separator
set statusline+=%1*\ ln:\ %02l/%L\ (%3p%%)\              " L.Num /L.Total, % viewed
set statusline+=%0*\ %n\                                 " Buffer number
hi User1 ctermfg=007 ctermbg=239 guibg=#4e4e4e guifg=#adadad
hi User2 ctermfg=007 ctermbg=236 guibg=#303030 guifg=#adadad
hi User3 ctermfg=236 ctermbg=236 guibg=#303030 guifg=#303030
hi User4 ctermfg=239 ctermbg=239 guibg=#4e4e4e guifg=#4e4e4e
