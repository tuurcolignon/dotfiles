#!/bin/bash
tmpbg=/tmp/swaylock-bg.png
grim $tmpbg
swaylock \
  --clock \
  --datestr "%a. %d/%m/%Y" \
  --indicator \
  --indicator-radius 100 \
  --indicator-thickness 8 \
  --ring-color 282a36 \
  --inside-color bd93f9 \
  --inside-clear-color bd93f9 \
  --inside-wrong-color cc382e \
  --inside-ver-color bd93f9 \
  --line-color 44475a \
  --text-color 282a36 \
  --key-hl-color bd93f9 \
  --separator-color 44475a \
  --ring-clear-color 282a36 \
  --ring-ver-color bd93f9 \
  --ring-wrong-color cc382e \
  --effect-blur 7x5 \
  --image $tmpbg &
sleep 10
#hyprctl dispatch dpms off
wait
rm $tmpbg

