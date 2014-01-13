sshd_role() {
  pkg world net-misc/openssh && \
  daemon enable sshd && \
  tmpl sshd_config /etc/ssh/sshd_config sshd
}
