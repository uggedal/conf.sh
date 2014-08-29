x_role() {
  pkg add xorg-minimal \
    xf86-video-$_x_video \
    xf86-input-$_x_input
}
