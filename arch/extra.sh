#!/bin/bash
#     _  ____               _
#    | ||  _ \  ___    ___ | |__    __ _
# _  | || |_) |/ _ \  / __|| '_ \  / _` |
#| |_| ||  _ <| (_) || (__ | | | || (_| |
# \___/ |_| \_\\___/  \___||_| |_| \__,_|


##### PIP Install
sudo pip3 install dbus-python pygobject

##### Setting audio
amixer sset Master unmute
amixer sset Speaker unmute
amixer sset Headphone unmute

##### TMP
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Press prefix + I (capital i, as in Install) to fetch the plugin.
