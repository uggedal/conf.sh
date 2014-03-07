lxc_role() {
  pkg accept =app-emulation/lxc-1.0.0 ~amd64 && \
  pkg world app-emulation/lxc \
    net-misc/bridge-utils && \
  pkg select bashcomp lxc
}
