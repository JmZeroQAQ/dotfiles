#!/bin/bash

current_path="${HOME}/.config/rofi/clipmenu"
case $1 in
    d) cliphist list | rofi -dmenu -replace -config ${current_path}/clipmenu.rasi | cliphist delete
       ;;

    w) cliphist wipe
       ;;

    *) cliphist list | rofi -dmenu -replace -config ${current_path}/clipmenu.rasi | cliphist decode | wl-copy
       ;;
esac
