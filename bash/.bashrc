case $- in
    *i*) ;;
      *) return;;
esac

# Vi Mode
set -o vi

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
# cd using names
shopt -s autocd

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=99999
HISTFILESIZE=99999

# resize
shopt -s checkwinsize

# # Fancy Prompt
# PS1="\[\e[1;31m\]["
# PS1+="\[\e[1;34m\]\u"
# PS1+="\[\e[1;33m\]@"
# PS1+="\[\e[1;34m\]\h"
# PS1+="\[\e[1;39m\] \W"
# PS1+="\[\e[1;31m\]]"
# export PS1+="\[\e[00m\]$ "

# Load Profile
[ -f ~/.profile ] && . ~/.profile
# fzf support
[ -f /usr/share/fzf/key-bindings.bash ] && . /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && . /usr/share/fzf/completion.bash
[ -f ~/.fzf.bash ] && . ~/.fzf.bash
# Check for cargo
[ -f ~/.cargo/env ] && . ~/.cargo/env
[ -z "$TMUX" ] && [ -f ~/.cache/wal/sequences ] && (cat ~/.cache/wal/sequences &)

eval "$(starship init bash)"
