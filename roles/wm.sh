wm_role() {
  pkg add xset \
    xrdb \
    setxkbmap \
    xsetroot \
    unclutter \
    autocutsel \
    herbstluftwm \
    dzen2 \
    dmenu \
    dejavu-fonts-ttf \
    rxvt-unicode \
    keychain \
    firefox \
    rtorrent \
    sxiv-git \
    mupdf \
    dbus \
    qemu \
    usbutils \
    p7zip \
    openconnect

  daemon enable dbus
}
