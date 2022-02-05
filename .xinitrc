source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

export _JAVA_AWT_WM_NONREPARENTING=1
export QT_STYLE_OVERRIDE=kvantum
# export QT_QPA_PLATFORMTHEME=gtk2

xsetroot -cursor_name left_ptr &
(feh --no-fehbg --bg-scale ~/.config/feh/background.png && picom) &

flameshot &
clipmenud &
GDK_BACKEND=x11 /usr/bin/ulauncher --hide-window --no-window-shadow &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
xbindkeys

setxkbmap -option caps:super

exec bspwm
