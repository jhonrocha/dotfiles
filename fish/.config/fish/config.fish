# My fish config. Not much to see here.  Some pretty standard stuff.
set -U fish_user_paths $fish_user_paths $HOME/.local/bin/
set -U fish_greeting                      # Supresses fish's intro message
set TERM "xterm-256color"              # Sets the terminal type
set EDITOR "emacsclient -t -a ''"      # $EDITOR use Emacs in terminal
set VISUAL "emacsclient -c -a emacs"   # $VISUAL use Emacs in GUI mode

### PROMPT ###
starship init fish | source

### DEFAULT EMACS MODE OR VI MODE ###
function fish_user_key_bindings
  # fish_default_key_bindings
  fish_vi_key_bindings
  fzf_key_bindings
end
### END OF VI MODE ###

### source alias
source ~/.alias
