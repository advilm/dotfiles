#!/bin/sh

notif() {
    brightness=$(brightnessctl -m | cut -d, -f4 | tr -d %)
    notify-call -i display-brightness-high-symbolic "Brightness:" -R "brightness-change" --hint int:value:"$brightness" -t 2000
}

up() {
    brightnessctl set 4+% -e
    notif
}

down() {
    brightnessctl set 4-% -e
    notif
}

case $1 in
    up) up ;;
    down) down ;;
    *) exit 1 ;;
esac
