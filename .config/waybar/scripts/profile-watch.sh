#!/bin/bash

PROFILE=$(powerprofilesctl get)
BRIGHTNESS=$(brightnessctl get)
BATTERY_CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)
CHARGER_CONNECTED=$(cat /sys/class/power_supply/AC/online)
FLAG="/tmp/power_saver_brightness_set"
FLAG_BATTERY="/tmp/power_profile_battery_set"
FLAG_CHARGER="/tmp/charger_set"

if [ "$BATTERY_CAPACITY" -le "57" ] && [ "$CHARGER_CONNECTED" = "0" ]; then
    if [ "$BATTERY_CAPACITY" -le "15" ]; then
        notify-send "BATTERY LEVEL CRITICAL" "please charge the battery"
        sleep 3
    fi
    if [ ! -f "$FLAG_BATTERY" ]; then
        notify-send "BATTERY LOW" "please charge the battery"
        powerprofilesctl set power-saver > /dev/null
        brightnessctl set 30% > /dev/null
        touch  "$FLAG_BATTERY"
        touch "$FLAG"
    fi
else
    rm -f "$FLAG_BATTERY"
fi

if [ "$PROFILE" = "power-saver" ]; then
    if [ ! -f "$FLAG" ]; then
        brightnessctl set 30% > /dev/null
        touch "$FLAG"
    fi
else
    rm -f "$FLAG"
fi

if [ "$CHARGER_CONNECTED" = "1" ] && ([ "$(powerprofilesctl get)" = "power-saver" ] || [ "$BRIGHTNESS" -le "851" ]); then
    if [ ! -f "$FLAG_CHARGER" ]; then
        touch "$FLAG_CHARGER"
        brightnessctl set 100% > /dev/null
    fi
    if [ "$(powerprofilesctl get)" = "power-saver" ]; then
        powerprofilesctl set balanced > /dev/null
    fi
    rm -f "$FLAG_BATTERY"
    rm -f "$FLAG"
else
    rm -f "$FLAG_CHARGER"
fi