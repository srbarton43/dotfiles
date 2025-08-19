. "$HOME/.cargo/env"

export _JAVA_AWT_WM_NONREPARENTING=1
export ELECTRON_OZONE_PLATFORM_HINT=auto



if [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ] ; then
    path_prefix=/usr/share/backgrounds/cosmic 
    # update background
    cp -f "$path_prefix/$(ls $path_prefix | sort -R | head -1)" /home/srbarton/.current_background.png
    exec sway
fi
