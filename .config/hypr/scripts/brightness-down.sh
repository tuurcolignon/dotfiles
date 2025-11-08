#!/bin/bash
STEP=85       # ~10% of 851
MIN=1
CUR=$(brightnessctl get)
NEW=$(( CUR - STEP ))
[ "$NEW" -le "$MIN" ] && NEW=$MIN
brightnessctl set "$NEW"
