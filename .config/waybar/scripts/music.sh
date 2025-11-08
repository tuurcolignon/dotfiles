#!/bin/bash
# Spotify Control Script for Waybar
# Usage: spotify-control.sh [status|toggle]

ACTION=${1:-status}

get_spotify_status() {
    # Check if Spotify is running
    if ! pgrep -x "spotify" > /dev/null; then
        echo "stopped"
        return
    fi
    
    # Get playerctl status specifically for Spotify
    local status=$(playerctl -p spotify status 2>/dev/null)
    echo "${status:-stopped}"
}

show_status() {
    local status=$(get_spotify_status)
    
    case "$status" in
        "Playing")
            echo '{"text": "⏸️", "class": "playing"}'
            ;;
        "Paused")
            echo '{"text": "▶", "class": "paused"}'
            ;;
        *)
            echo '{"text": "▶", "class": "stopped"}'
            ;;
    esac
}

show_combined() {
    local status=$(get_spotify_status)
    
    case "$status" in
        "Playing")
            echo '{"text": "🡨 ⏸ 🡪", "class": "playing"}'
            ;;
        "Paused")
            echo '{"text": "🡨 ▶ 🡪", "class": "paused"}'
            ;;
        *)
            echo '{"text": "🡨 ▶ 🡪", "class": "stopped"}'
            ;;
    esac
}

toggle_playback() {
    local status=$(get_spotify_status)
    
    case "$status" in
        "Playing")
            playerctl -p spotify pause
            ;;
        "Paused")
            playerctl -p spotify play
            ;;
        *)
            # Spotify not running or stopped
            if ! pgrep -x "spotify" > /dev/null; then
                # Launch Spotify in background
                spotify-launcher &
                wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
                # Wait a moment for Spotify to start
                sleep 2
                # Wait for Spotify to be ready (max 10 seconds)
                for i in {1..10}; do
                    if playerctl -p spotify status &>/dev/null; then
                        break
                    fi
                    sleep 1
                done
            fi
            # Start playback
            playerctl -p spotify play 2>/dev/null
            ;;
    esac
}

case "$ACTION" in
    "status")
        show_status
        ;;
    "toggle")
        toggle_playback
        ;;
    *)
        echo "Usage: $0 [status|toggle]"
        exit 1
        ;;
esac