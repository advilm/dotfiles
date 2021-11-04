source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORMTHEME=qt5ct

xsetroot -cursor_name left_ptr &
~/.config/polybar/launch.sh &
(feh --no-fehbg --bg-scale ~/.config/feh/background.png && picom) &

flameshot &
clipmenud &
dunst &
imwheel -f
~/scripts/tablet.sh
xbindkeys

setxkbmap -option caps:super

exec bspwm
