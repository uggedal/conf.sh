sound_role() {
  pkg add alsa-utils

  tmpl asound.conf /etc/asound.conf
}
