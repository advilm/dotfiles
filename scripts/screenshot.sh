! (flameshot gui -r 2>&1 1> ~/downloads/sc.png | grep abort) || exit

xsel -bd
upload ~/downloads/sc.png | jq -r .files[0] | xsel -ib
notify-send -i flameshot 'Uploaded Screenshot'

# flameshot gui
