#!/bin/bash
while :
do
    # Get brightness percentage
    value=$(( 100 * $(brightnessctl get) / ($(brightnessctl max)-1) ))
    
    # Create bar representation (10 segments)
    bar=""
    filled=$(( value / 10 ))
    
    # Add filled segments
    for (( i=0; i<filled; i++ )); do
        bar+="▓"
    done
    
    # Add empty segments
    for (( i=filled; i<10; i++ )); do
        bar+="░"
    done
    
    echo "{\"text\": \"$bar\", \"class\": \"bar\"}"
    sleep 0.2
done