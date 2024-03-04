#!/bin/bash

LOCK_TIME=500
DISPLAY_OFF_TIME=800
SUSPEND_TIME=1000

swayidle timeout ${LOCK_TIME} "swaylock" \
         timeout ${DISPLAY_OFF_TIME} "hyprctl dispatcher dpms off" \
            resume "hyprctl dispatcher dpms on" \
         timeout ${SUSPEND_TIME} "systemctl suspend" \
         before-sleep "swaylock"
