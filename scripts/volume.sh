#!/bin/sh

notif () {
    volume=$(pamixer --get-volume)
    if [ $volume -eq 0 ] || [ "$(pamixer --get-mute)" = "true" ]; then
        notify-call -i audio-volume-muted-symbolic "Volume: " -R "volume-change" --hint int:value:"$volume" -t 2000
    else if [ $volume -lt 33 ]; then
            notify-call -i audio-volume-low-symbolic "Volume: " -R "volume-change" --hint int:value:"$volume" -t 2000
        else if [ $volume -lt 66 ]; then
                notify-call -i audio-volume-medium-symbolic "Volume: " -R "volume-change" --hint int:value:"$volume" -t 2000
            else
                notify-call -i audio-volume-high-symbolic "Volume: " -R "volume-change" --hint int:value:"$volume" -t 2000
            fi
        fi
    fi
}

up() {
    pactl set-sink-volume @DEFAULT_SINK@ +4%
    notif
}

down() {
    pactl set-sink-volume @DEFAULT_SINK@ -4%
    notif
}

mute() {
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    notif
}

case $1 in
    mute) mute ;;
    up) up ;;
    down) down ;;
    *) exit 1 ;;
esac
