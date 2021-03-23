" Easier search
noremap <leader>s /
" List cwd files
nnoremap <silent> <leader><Space> :FZF -m --no-preview<CR>
" Last buffer
nnoremap <leader><TAB> <C-^>
" List open buffers
nnoremap <silent> <leader>, :Buffers<CR>
" List locals files
noremap <silent> <Leader>. :FZF <C-R>=expand("%:p:h") . "/"<CR><CR>

" Window Directions Maps
noremap <leader>j <C-w>j
noremap <leader>k <C-w>k
noremap <leader>l <C-w>l
noremap <leader>h <C-w>h
" Close the current buffer and move to the previous one
noremap <leader>xk :bd<CR>
noremap <leader>fq :bp <BAR> bd #<CR>
" Saving Shortcut
noremap <leader>xs :update<CR>

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
