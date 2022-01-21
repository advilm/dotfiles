flameshot gui -r > ~/downloads/sc.png || exit
URL=$(upload ~/downloads/sc.png | jq -r .files[0])

echo -n $URL | xsel -ib

ACTION=$(dunstify -i flameshot --action="default,open" "Uploaded Screenshot" "$URL")

if [ "$ACTION" = "default" ]
then
  xdg-open $URL
fi

# flameshot gui
