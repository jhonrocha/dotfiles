# PATH
PATH="$HOME/go/bin:$PATH"
PATH="$HOME/.config/scripts:$PATH"
PATH="$HOME/.config/.privateScripts:$PATH"
PATH="$HOME/.config/npm-global/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="/usr/local/opt/node@8/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/node@8/lib"
export CPPFLAGS="-I/usr/local/opt/node@8/include"
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export EDITOR="nvim"
export TERM="kitty"
export XTERM="kitty"
export TERMCMD="kitty"
export FILE="ranger"
export BROWSER="firefox"
export BROWSER_NAME="Navigator"
export SXHKD_SHELL="/bin/sh"

# CONFIGS
export PKG_CONFIG_PATH=/usr/local/Cellar/libffi/3.2.1/lib/pkgconfig/
export LC_ALL=en_US.UTF-8
export FZF_DEFAULT_OPTS="--layout=reverse --border"
export XDG_CONFIG_HOME="$HOME/.config"
export GTK_THEME=Adwaita:Dark

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
alias g.p="cd ~/privatedotfiles"
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
alias ta='tmux attach'
alias tls='tmux ls'
alias tat='tmux attach -t'
alias tns='tmux new-session -s'
alias t1='tmux new-session -A -s 1'
alias t2='tmux new-session -A -s 2'
alias t3='tmux new-session -A -s 3'
alias t4='tmux new-session -A -s 4'
alias t5='tmux new-session -A -s 5'
alias t6='tmux new-session -A -s 6'
alias t7='tmux new-session -A -s 7'
alias t8='tmux new-session -A -s 8'
alias t9='tmux new-session -A -s 9'
alias t0='tmux new-session -A -s 0'
# Ranger
alias lf='ranger'
# Neovim
alias n='nvim'
# Vim
alias v='vim'
# Tree
alias t='tree -a -I ".git|node_modules"'
# BRoot
alias b='br -h'
# Rofi replace dmenu
alias dmenu="rofi -dmenu"
# NVM Init
alias nvm-init=". /usr/share/nvm/init-nvm.sh"

##### BASHSMS #####
# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Functions
fm ()
{
  # Block nesting of nnn in subshells
  if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
      echo "nnn is already running"
      return
  fi
  # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
  # stty start undef
  # stty stop undef
  # stty lwrap undef
  # stty lnext undef
  NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
  nnn "$@"
  if [ -f "$NNN_TMPFILE" ]; then
          . "$NNN_TMPFILE"
          rm -f "$NNN_TMPFILE" > /dev/null
  fi
}
 
[ -f ~/.config/.rauxa_envs ] && . ~/.config/.rauxa_envs
