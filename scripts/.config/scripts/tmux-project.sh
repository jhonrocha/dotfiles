#!/usr/bin/env bash
# List options to pen a new session, window, pane or horizontal pane by location
# By Jhon
launcher_cmd() {
  if [ "$1" = "fzf-tmux" ]; then
    fzf-tmux -d 35% --multi --exit-0 --cycle --reverse --bind='ctrl-r:toggle-all' --bind='ctrl-s:toggle-sort' --no-preview --header="Launch project"
  elif [ "$1" = "dmenu" ]; then
    dmenu -p "Launch project" -i -l 10 
  else
    # Simply use the command
    $1
  fi
}

launcher=$1
file=$2

# Choose
launcher_cmd "$launcher" < $file | { read -r path name
  if [[ "$name" ]]; then
    tmux select-window $name || tmux new-window -c $path -n $name 'nvim -c :Files ; bash'
  elif [[ "$path" ]]; then
    tmux new-window -c $path 'nvim -c :Files ; bash' 
  fi
}
