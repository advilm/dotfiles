if [ "$(xfconf-query -c xsettings -p /Net/ThemeName)" = "Matcha-dark-azul" ]; then
    xfconf-query -c xsettings -p /Net/ThemeName -s "Matcha-azul"
    xfconf-query -c xfce4-notifyd -p /theme -s "Matcha-azul"
    cp ~/.config/alacritty/alacritty-light.yml ~/.config/alacritty/alacritty.yml
    cp ~/.config/polybar/config-light ~/.config/polybar/config
    cp ~/.config/ulauncher/user-themes/advil/manifest-light.json ~/.config/ulauncher/user-themes/advil/manifest.json
    cp ~/.config/ulauncher/user-themes/advil/theme-light.css ~/.config/ulauncher/user-themes/advil/theme.css
    pkill ulauncher; GDK_BACKEND=x11 ulauncher --hide-window --no-window-shadow &
    hsetroot -solid '#ebedef'
else
    xfconf-query -c xsettings -p /Net/ThemeName -s "Matcha-dark-azul"
    xfconf-query -c xfce4-notifyd -p /theme -s "Matcha-dark-azul"
    cp ~/.config/alacritty/alacritty-dark.yml ~/.config/alacritty/alacritty.yml
    cp ~/.config/polybar/config-dark ~/.config/polybar/config
    cp ~/.config/ulauncher/user-themes/advil/manifest-dark.json ~/.config/ulauncher/user-themes/advil/manifest.json
    cp ~/.config/ulauncher/user-themes/advil/theme-dark.css ~/.config/ulauncher/user-themes/advil/theme.css
    pkill ulauncher; GDK_BACKEND=x11 ulauncher --hide-window --no-window-shadow &
    hsetroot -solid '#020e1d'
fi
