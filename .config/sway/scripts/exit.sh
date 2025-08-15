#!/bin/bash

RESP=$(cat <<EOF | fzf +s --tac \
--style=minimal --color=dark --border=double \
--border-label='Exit Menu' \
--no-scrollbar --no-info --no-separator 
Shutdown
Reboot
Suspend
Display Off
Lock
Exit
EOF
);

case "$RESP" in
	Shutdown)
		systemctl poweroff
		;;
	Reboot)
		systemctl reboot
		;;
	Suspend)
		systemctl suspend
		;;
  'Display Off')
    swaymsg 'output * power off'
    ;;
	Lock)
		~/.config/sway/scripts/lock.sh
		;;
	Exit)
		swaymsg exit
		;;
	*)
		exit 1
esac

