wm_role() {
  pkg add dbus \
    xset \
    xrdb \
    setxkbmap \
    xsetroot \
    unclutter \
    autocutsel \
    bspwm \
    sxhkd \
    bar-git \
    xtitle \
    dmenu \
    terminus-font \
    dejavu-fonts-ttf \
    rxvt-unicode \
    keychain \
    xrandr \
    physlock

  daemon enable dbus
}
