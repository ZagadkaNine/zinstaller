#!/bin/bash
now=$(date +'%Y_%m_%d_%I%M%S')
maim --select $HOME/Downloads/screenshots/screenshot_zone_${now}.png && notify-send "Screenshot of selected zone saved to ~/Downloads/screenshots/screenshot_zone_${now}.png"
