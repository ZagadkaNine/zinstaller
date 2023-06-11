#!/bin/bash
now=$(date +'%Y_%m_%d_%I%M%S')
maim -i "$(xdotool getactivewindow)" $HOME/Downloads/screenshots/screenshot_active_windows_${now}.png && notify-send "Active window screenshot saved to ~/Downloads/screenshots/screenshot_active_windows_${now}.png"
