sshd_role() {
  pkg use net-misc/openssh -hpn
  pkg world net-misc/openssh && \
  daemon enable sshd && \
  tmpl sshd_config /etc/ssh/sshd_config sshd
}
