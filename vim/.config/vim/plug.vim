"# Plug For Managing Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('nvim')
  let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
  let g:vim_bootstrap_editor = "nvim"				" nvim or vim
else
  let vimplug_exists=expand('~/.vim/autoload/plug.vim')
  let g:vim_bootstrap_editor = "vim"				" nvim or vim
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
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rhubarb' " required by fugitive to :Gbrowse
" Use RipGrep and others
Plug 'vim-scripts/grep.vim'
" Snippets
Plug 'honza/vim-snippets'
" Indentation
Plug 'Yggdroot/indentLine'
" Languages Support
Plug 'sheerun/vim-polyglot'
" Show Marks
Plug 'kshenoy/vim-signature'
" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" FZF
if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif
let g:make = 'gmake'
if exists('make')
        let g:make = 'make'
endif
" Distraction Free
Plug 'junegunn/goyo.vim'
" Vimwiki
Plug 'vimwiki/vimwiki'
" Themes
Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()
