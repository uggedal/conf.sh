wm_role() {
  pkg add dbus \
    xset \
    xrdb \
    setxkbmap \
    xsetroot \
    unclutter \
    autocutsel \
    herbstluftwm \
    lemonbar \
    dmenu \
    terminus-font \
    dejavu-fonts-ttf \
    rxvt-unicode \
    xrandr \
    physlock

  daemon enable dbus
}
