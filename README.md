# Setup

## Cloning
```bash
git clone --bare git@github.com:advilm/dotfiles.git .dotfiles
function config { /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@; }
config checkout
config submodule update --init --recursive
```

## Packages 
```bash
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```
```bash
paru -S adobe-source-han-sans-cn-fonts adobe-source-han-sans-hk-fonts adobe-source-han-sans-jp-fonts adobe-source-han-sans-kr-fonts adobe-source-han-sans-otc-fonts adobe-source-han-sans-tw-fonts adobe-source-han-serif-cn-fonts adobe-source-han-serif-hk-fonts adobe-source-han-serif-jp-fonts adobe-source-han-serif-kr-fonts adobe-source-han-serif-otc-fonts adobe-source-han-serif-tw-fonts alacritty antibody arch-install-scripts ark baobab barrier bat bc blueman bluez-utils bspwm cheese chromium clipmenu cpu-x digimend-kernel-drivers-dkms-git docker docker-compose dust dvm firefox-developer-edition flameshot flatpak gnome-calculator gnome-clocks gnome-font-viewer gnome-keyring gnome-logs gnome-screenshot gnome-tweaks gotop heroic-games-launcher-bin htop jmtpfs jq kdeconnect kdenlive krita kvantum-theme-qogir-git lutris maim mangohud matcha-gtk-theme microsoft-edge-dev-bin mpv nautilus neofetch nethogs nodejs npm openssh pavucontrol peek picom pipewire pipewire-alsa pipewire-media-session pipewire-pulse pitivi playerctl polybar postman-bin powertop proton-ge-custom-bin psensor qogir-icon-theme-git redshift ripgrep rofi rsync scrcpy seahorse signal-desktop simplescreenrecorder sl spotify-adblock-git sshfs steam-native-runtime sxhkd tealdeer texinfo texlive-bibtexextra texlive-fontsextra texlive-formatsextra texlive-latexextra texlive-latexindent-meta texlive-publishers texlive-science tor-browser tree ttf-jetbrains-mono ttf-liberation ttf-meslo-nerd-font-powerlevel10k ttf-ms-fonts ttf-twemoji ttf-windows ulauncher upower v4l2loopback-dkms ventoy-bin virt-manager virtualbox virtualbox-host-dkms visual-studio-code-insiders-bin vlc wget wireguard-tool wmctrl xbindkeys xclip xdotool xfce4-notifyd xorg xournalpp xpra xsel youtube-dl zoom zsh
```
