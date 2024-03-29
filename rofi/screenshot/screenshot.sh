#!/bin/bash


# Import Current Theme
DIR="$HOME/.config/rofi/screenshot/"
RASI="$DIR/screenshot.rasi"

# Theme Elements
prompt='Screenshot'
mesg="Directory:$(HOME)/Pictures/Screenshot"

# Options
layout=$(cat ${RASI} | grep 'USE_ICON' | cut -d'=' -f2)
if [[ "$layout" == 'NO' ]]; then
	option_1=" Capture Desktop"
	option_2=" Capture Area"
	option_3=" Capture Window"
	option_4=" Capture in 5s"
	option_5=" Capture in 10s"
else
	option_1=""
	option_2=""
	option_3=""
	option_4=""
	option_5=""
fi

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme ${RASI}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5" | rofi_cmd
}

# Image Name
Name="${HOME}/Pictures/ScreenShot/$(date "+%Y-%m-%d-%H-%M-%S").png"

# Screenshot Mode
screenshot_full() {
  grim "${Name}"
	notify-send -i "${Name}" "已经保存图片"
}

screenshot_area() {
	grim -c -t png -g "$(slurp -d -b "#00000000" -c "#82AAFFFF" -s "#00000044" && sleep 0.7)" ~/Pictures/Screenshots/"${Name}"-area.png
	notify-send -h string:x-canonical-private-synchronous:sys-notify -i ~/Pictures/Screenshots/"${Name}"-area.png -a "$(python3 ~/.config/hypr/scripts/ramdomtext.py)" " "
}

screenshot_window() {
	grim -c -t png -g "$(
		echo -n $(hyprctl activewindow | grep at: | awk -F ': ' '{print $2}')
		hyprctl activewindow | grep size | awk -F ': ' '{print $2}' | awk -F ',' '{print " "$1"x"$2}'
	)" ~/Pictures/Screenshots/"${Name}"-window.png
	notify-send -h string:x-canonical-private-synchronous:sys-notify -i ~/Pictures/Screenshots/"${Name}"-window.png -a "$(python3 ~/.config/hypr/scripts/ramdomtext.py)" " "
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
		sleep 0.7 && screenshot_full
	elif [[ "$1" == '--opt2' ]]; then
		screenshot_area
	elif [[ "$1" == '--opt3' ]]; then
		sleep 0.7 && screenshot_window
	elif [[ "$1" == '--opt4' ]]; then
		sleep 5 && screenshot_full
	elif [[ "$1" == '--opt5' ]]; then
		sleep 10 && screenshot_full
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
$option_1)
	run_cmd --opt1
	;;
$option_2)
	run_cmd --opt2
	;;
$option_3)
	run_cmd --opt3
	;;
$option_4)
	run_cmd --opt4
	;;
$option_5)
	run_cmd --opt5
	;;
esac
