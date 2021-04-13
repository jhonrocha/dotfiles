# PATH
PATH="$HOME/go/bin:$PATH"
PATH="$HOME/.config/scripts:$PATH"
PATH="$HOME/.config/.privateScripts:$PATH"
PATH="$HOME/.config/npm-global/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="/usr/local/opt/node@8/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/node@8/lib"
export CPPFLAGS="-I/usr/local/opt/node@8/include"
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export EDITOR="nvim"
export TERM=xterm-256color
export XTERM=xterm-256color
export TERMCMD=kitty
export FILE=ranger
export BROWSER=brave
export BROWSER_NAME=Brave-broser
export SXHKD_SHELL=/bin/sh

# CONFIGS
export PKG_CONFIG_PATH=/usr/local/Cellar/libffi/3.2.1/lib/pkgconfig/
export LC_ALL=en_US.UTF-8
export FZF_DEFAULT_OPTS="--layout=reverse --border --cycle --multi --bind ctrl-a:toggle-all,ctrl-u:preview-up,ctrl-d:preview-down,ctrl-s:toggle-preview"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export XDG_CONFIG_HOME="$HOME/.config"
export GTK_THEME=Materia-compact
export BAT_THEME="gruvbox-dark"

## Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\e[30;43m'       # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline

# NNN Bookmarks
export NNN_BMS='h:~;.:~/dotfiles;D:~/Documents;d:~/Downloads;1:~/oneDrive;o:~/org;k:~/keys;w:~/workspace;j:~/jhworkspace;p:~/Pictures'
export NNN_FIFO=/tmp/nnn.fifo
export NNN_PLUG='a:preview-tui;p:preview-tabbed;v:imgview'

# Config
export WINEPREFIX=~/.config/wine

# Alias definitions.
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
# Shortcuts
alias gw="cd ~/workspace"
alias gj="cd ~/jhworkspace"
alias g.="cd ~/dotfiles"
alias g,="cd ~/privatedotfiles"
alias g1="cd ~/oneDrive"
alias gd="cd ~/Downloads"
alias gD="cd ~/Documents"
alias gt="cd ~/Desktop"
alias gp="cd ~/workspace/pr"
alias gk="cd ~/keys"
alias gg="cd ~/org"
alias gl="git log --pretty=format:\"[%h] %ae, %ar: %s\" --stat"
# List all files
alias l="exa -a --group-directories-first"
alias ll="exa -la --group-directories-first"
# Copy to clipboard
alias clip="yank"
# EMACS
alias ec="emacsclient -n"
# pwd
alias p=pwd
# tmux aliases
alias t='tmux new-session -A -s code "tmux-project ; bash"'
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
# Rofi replace dmenu
alias dmenu="rofi -dmenu"
# NVM Init
alias nvm-init=". /usr/share/nvm/init-nvm.sh"

##### BASHSMS #####
# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

[ -f ~/.config/.rauxa_envs ] && . ~/.config/.rauxa_envs
[ -x "$(command -v rustc)" ] && export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/library;
