#! /bin/env bash
if [[ ! "$PLAYER_EVENT" = 'change' ]]; then
  exit 0
fi

albumart_fn=/tmp/"$(date -u +%V$(uname)|sha224sum|sed 's/\W//g').jpeg"
PID=$(pidof spotifyd)
plctl_id="spotifyd.instance$PID"

image_url=$(playerctl -p $plctl_id metadata | grep -o 'https.*')
wget --quiet "$image_url" -O "$albumart_fn"

title=$(playerctl -p $plctl_id metadata title)
album=$(playerctl -p $plctl_id metadata album)
artist=$(playerctl -p $plctl_id metadata artist)

notify-send -a spotifyd -i "$albumart_fn" "$title" "$artist
$album"
