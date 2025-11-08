#!/bin/bash

OPTIONS="Shutdown\nReboot\nSuspend"

choice=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Power Menu")

case "$choice" in
  Suspend) systemctl suspend ;;
  Shutdown) systemctl poweroff ;;
  Reboot) systemctl reboot ;;
  *) exit 1 ;;
esac
