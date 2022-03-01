#!/bin/sh

scrot -o /tmp/screenshot.png
convert /tmp/screenshot.png -blur 0x5 /tmp/screenshot.png

# Turn on DND
old_dnd="$(xfconf-query -c xfce4-notifyd -p /do-not-disturb)"
xfconf-query -c xfce4-notifyd -p /do-not-disturb -s true

# Pause stuff and mute audio
playerctl -a pause > /dev/null
old_mute="$(amixer get Master | tail -2 | grep '\[on\]')"
amixer set Master mute > /dev/null

# Waits for i3lock to die or valid fingerprint to kill i3lock
wait_fingerprint() {
    while pidof i3lock > /dev/null; do
        if (timeout 5 fprintd-verify | grep -q verify-match); then
            pkill i3lock
        fi
    done
}

# Code taken from xss-lock transfer sleep lock example
if [[ -e /dev/fd/${XSS_SLEEP_LOCK_FD:--1} ]]; then
    kill_i3lock() {
        pkill -xu $EUID "$@" i3lock
    }
    
    trap kill_i3lock TERM INT
    
    # we have to make sure the locker does not inherit a copy of the lock fd
    i3lock -ui /tmp/screenshot.png {XSS_SLEEP_LOCK_FD}<&-
    
    # now close our fd (only remaining copy) to indicate we're ready to sleep
    exec {XSS_SLEEP_LOCK_FD}<&-
    
    wait_fingerprint
else
    trap 'kill %%' TERM INT
    i3lock -nui /tmp/screenshot.png &
    wait_fingerprint
fi

# Set settings back to what they were before
test -z "$old_mute" || amixer set Master unmute > /dev/null
test "$old_dnd" = false && xfconf-query -c xfce4-notifyd -p /do-not-disturb -s false