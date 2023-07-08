#!/usr/bin/env bash

picom &
killall volumeicon &
volumeicon &
nm-applet &
gnome-screensaver &
nitrogen --restore &

