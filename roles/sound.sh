sound_role() {
  pkg add alsa-utils &&
    tmpl -s /etc/asound.conf &&
    daemon enable alsa
}
