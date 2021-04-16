# Install paru
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

# Install rest of the packages
paru -S xorg-xsetroot polybar feh picom flameshot clipmenu rofi dunst bspwm sxhkd pipewire pipewire-pulse pipewire pipewire-alsa pipewire-jack pipewire-media-session pulseeffects discord-development firefox-developer-edition alacritty ttf-liberation ttf-mac-fonts ttf-ms-fonts ttf-roboto ttf-symbola ttf-twemoji ttf-unifont ttf-windows ttf-bitstream-vera ttf-hack ttf-meslo-nerd-font-powerlevel10k dina-font siji zsh antibody xsel xdotool steam-native-runtime tealdeer rsync dust bat cpu-x 
