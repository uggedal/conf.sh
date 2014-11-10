wm_role() {
  pkg add dbus \
    xset \
    xrdb \
    setxkbmap \
    xsetroot \
    unclutter \
    autocutsel \
    i3 \
    i3blocks \
    dmenu \
    terminus-font \
    dejavu-fonts-ttf \
    rxvt-unicode \
    xrandr \
    physlock

  daemon enable dbus
}
