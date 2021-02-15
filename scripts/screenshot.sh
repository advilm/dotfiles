flameshot gui -r > ~/downloads/sc.png || exit
URL=$(upload ~/downloads/sc.png)

echo -n $URL | xsel -ib

ACTION=$(dunstify -i flameshot --action="default,open" "Uploaded Screenshot" "$URL")

if [ "$ACTION" = "default" ]
then
  xdg-open $URL
  wmctrl -a firefox
fi

# flameshot gui
