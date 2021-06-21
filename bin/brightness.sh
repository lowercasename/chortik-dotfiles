#!/bin/bash

basedir="/sys/class/backlight/"
# Get the backlight handler (this only works if there's a single handler)
handler=$basedir$(ls $basedir)"/"

max_brightness=$(cat $handler"max_brightness")
current_brightness=$(cat $handler"brightness")
new_brightness=$current_brightness
brightness_increment=300

if [ $# -lt 1 ]; then
	exit
else
    if [ "$1" == "up" ]; then
        # Set brightness to max if the brightness is at or almost at max
        if [ $current_brightness -ge $(($max_brightness-$brightness_increment)) ]; then
            new_brightness=$max_brightness
        else
            new_brightness=$(($current_brightness+$brightness_increment))
        fi
    else
        # Set brightness to 0 if the brightness is at or almost at min
        if [ "$current_brightness" -le $((0+$brightness_increment)) ]; then
            new_brightness=0
        else
            new_brightness=$(($current_brightness-$brightness_increment))
        fi
    fi
    echo $new_brightness > $handler"brightness"
fi
