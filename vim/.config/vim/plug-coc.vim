" Extensions
let g:coc_global_extensions = [
      \'coc-eslint',
      \'coc-git',
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
