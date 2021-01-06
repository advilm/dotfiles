export _JAVA_AWT_WM_NONREPARENTING=1;
(feh --no-fehbg --bg-scale ~/.config/feh/background.png && picom) &
xsetroot -cursor_name left_ptr &
~/.config/polybar/launch.sh
flameshot &
exec bspwm
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
