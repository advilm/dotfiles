#! (flameshot gui -r 2>&1 1> ~/downloads/sc.png | grep abort) || exit

#xsel -bd

flameshot gui -r > ~/downloads/sc.png
xclip -selection clipboard -t image/png -i ~/downloads/sc.png

#upload ~/downloads/sc.png | jq -r .files[0] | xsel -ib
