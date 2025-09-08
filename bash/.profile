# AMD/NVIDIA
export VDPAU_DRIVER=radeonsi

# XDG Standard
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local"
export XDG_STATE_HOME="$HOME/.local/state"

# Keyring
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh
# PATH
PATH="$HOME/.config/dotbin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$XDG_DATA_HOME/venv/bin:$PATH"
PATH="$HOME/bin:$PATH"
# bun
BUN_INSTALL="$XDG_CONFIG_HOME/bun"
PATH="$BUN_INSTALL/bin:$PATH"

# Applications
export EDITOR="nvim"
export FILE=ranger
export BROWSER=google-chrome-stable
export BROWSER_NAME=google-chrome
export SXHKD_SHELL=/bin/sh

# Fix Java Fonts: https://wiki.archlinux.org/title/Java_Runtime_Environment_fonts
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp -Dswing.aatext=true'

#TFENV
export TFENV_TERRAFORM_VERSION=1.8.4

# UI
# export GDK_SCALE=2


# CONFIGS
export PKG_CONFIG_PATH=/usr/local/Cellar/libffi/3.2.1/lib/pkgconfig/
export LC_ALL=en_US.UTF-8
export FZF_DEFAULT_OPTS="--layout=reverse
--history=$HOME/.cache/.fzf_history
--border --cycle --multi
--bind 'ctrl-y:execute(readlink -f {} | xclip -selection clipboard)'
--bind 'ctrl-alt-y:execute-silent(xclip -selection clipboard {})'
--bind ctrl-a:toggle-all,ctrl-u:preview-up,ctrl-d:preview-down,ctrl-s:toggle-preview
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#313244,label:#CDD6F4"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export BAT_THEME="gruvbox-dark"
export QT_QPA_PLATFORMTHEME=qt5ct

# XDGG
export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"
export ASDF_DATA_DIR="$XDG_CONFIG_HOME/.asdf"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME"/starship.toml
export STARSHIP_CACHE="$XDG_CACHE_HOME"/starship
export CARGO_HOME="$XDG_CONFIG_HOME/.cargo"
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
PATH="$CARGO_HOME/bin:$PATH"
export GNUPGHOME="$XDG_CONFIG_HOME/.gnupg"
export MOZILLA_CONFIG="$XDG_CONFIG_HOME/.mozilla"
export GOPATH="$XDG_DATA_HOME"/go
PATH="$GOPATH/bin:$PATH"
export GOMODCACHE="$XDG_CACHE_HOME"/go/mod
export HISTFILE="$XDG_STATE_HOME"/bash/history
export PYTHONPYCACHEPREFIX=$XDG_CACHE_HOME/python
export PYTHONUSERBASE=$XDG_DATA_HOME/python
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PSQL_HISTORY="$XDG_STATE_HOME/psql_history"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"
export PATH="$XDG_CONFIG_HOME/npm-global/bin:$PATH"
export OLLAMA_MODELS=$XDG_DATA_HOME/ollama/models

export PATH="${XDG_CONFIG_HOME}/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="${XDG_CONFIG_HOME}/herd-lite/bin:$PHP_INI_SCAN_DIR"


alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'
alias yarn='fnm exec --using .nvmrc yarn'

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
alias g.="cd /data/dotfiles > /dev/null 2>&1 || cd ~/dotfiles"
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
# Helix
alias hx='helix'
# Vim
alias v='vim'
# Tree
alias tre='tree -a -I ".git|node_modules"'
# BRoot
alias b='br -h'
# kubectl
alias kd="KUBECONFIG=~/.kube/dev.yaml kubectl"
alias kprod="KUBECONFIG=~/.kube/prod.yaml kubectl"

alias lg=lazygit

alias nvm="fnm"

##### BASHSMS #####
# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

[ -x "$(command -v rustc)" ] && export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/library;

# RUST
[ -f ~/.cargo/env ] && . ~/.cargo/env
# Private envs
[ -f ~/.config/.private_env ] && . ~/.config/.private_env
# [ -f /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh
# eval "$(fnm env --use-on-cd --log-level error)"
eval "$(fnm env --log-level error)"
