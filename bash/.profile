# PATH
PATH="$HOME/go/bin:$PATH"
PATH="$HOME/.config/dotbin:$PATH"
PATH="$HOME/.config/prvbin:$PATH"
PATH="$HOME/.config/npm-global/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="/usr/local/opt/node@8/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/node@8/lib"
export CPPFLAGS="-I/usr/local/opt/node@8/include"
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export EDITOR="nvim"
export FILE=ranger

# export BROWSER=brave
export BROWSER=vivaldi-stable
export BROWSER_NAME=vivaldi-stable
export SXHKD_SHELL=/bin/sh

# CONFIGS
export PKG_CONFIG_PATH=/usr/local/Cellar/libffi/3.2.1/lib/pkgconfig/
export LC_ALL=en_US.UTF-8
export FZF_DEFAULT_OPTS="--layout=reverse
--history=$HOME/.cache/.fzf_history
--border --cycle --multi
--bind 'ctrl-y:execute(readlink -f {} | xclip -selection clipboard)'
--bind 'ctrl-alt-y:execute-silent(xclip -selection clipboard {})'
--bind ctrl-a:toggle-all,ctrl-u:preview-up,ctrl-d:preview-down,ctrl-s:toggle-preview"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export XDG_CONFIG_HOME="$HOME/.config"
export GTK_THEME=Arc-Dark
export BAT_THEME="gruvbox-dark"
export QT_STYLE_OVERRIDE=Breeze-Dark

## Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\e[30;43m'       # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline

# Config
export WINEPREFIX=~/.config/wine

# Alias definitions.
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
# Shortcuts
alias gw="cd ~/workspace"
alias gh="cd ~/homefree"
alias ga="cd ~/anjuna/"
alias gj="cd /data"
alias g.="cd /data/dotfiles"
alias gd="cd ~/Downloads"
alias gD="cd ~/Documents"
alias gt="cd ~/Desktop"
alias gk="cd ~/prvdots/keys"
alias gg="cd ~/org"
alias gp="cd ~/Pictures"
# Make
alias m="make"
# List all files
alias l="exa --group-directories-first --icons"
alias la="exa -a --group-directories-first --icons"
alias ll="exa -la --group-directories-first --icons"
# Copy to clipboard
alias clip="yank"
# EMACS
alias ec="emacsclient -n"
# pwd
alias p=pwd
# tmux aliases
alias t='tmux new-session -A -s code "tmux-project 2>/dev/null; zsh"'
alias ta='tmux attach'
alias tls='tmux ls'
alias t1='tmux new-session -A -s 1'
alias t2='tmux new-session -A -s 2'
alias t3='tmux new-session -A -s 3'
# Ranger
alias fm='ranger'
# Neovim
alias n='nvim'
# Vim
alias v='vim'
# Tree
alias tre='tree -a -I ".git|node_modules"'
# BRoot
alias b='br -h'
# NVM Init
alias nvm-init=". /usr/share/nvm/init-nvm.sh"

##### BASHSMS #####
# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

[ -f ~/.config/.prvenvs ] && . ~/.config/.prvenvs
[ -x "$(command -v rustc)" ] && export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/library;
