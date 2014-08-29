wifi_role() {
  pkg add iw \
    wpa_supplicant \
    wifi-firmware

  file wpa_supplicant-interface.conf \
    /etc/wpa_supplicant/wpa_supplicant-${_wifi_interface}.conf
}
