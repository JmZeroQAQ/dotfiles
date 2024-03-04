#!/usr/bin/env bash

## Copyright (C) 2020-2023 Aditya Shakya <adi1090x@gmail.com>

# Import Current Theme
RASI="../themes/catppuccin-mocha.rasi"

# rofi text dialog to get password
rofi -dmenu \
	-password \
	-i \
	-p "Root" \
	-theme ${RASI}
