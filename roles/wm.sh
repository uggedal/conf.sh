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
    dmenu \
    dejavu-fonts-ttf \
    rxvt-unicode \
    keychain \
    xrandr

  daemon enable dbus
}
