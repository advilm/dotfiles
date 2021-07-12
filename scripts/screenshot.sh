flameshot gui -r > ~/downloads/sc.png || exit
URL=$(upload ~/downloads/sc.png | jq -r .url)

echo -n $URL | xsel -ib

ACTION=$(dunstify -i flameshot --action="default,open" "Uploaded Screenshot" "$URL")

if [ "$ACTION" = "default" ]
then
  xdg-open $URL
fi

# flameshot gui
