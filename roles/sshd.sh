sshd_role() {
  pkg add openssh && \
    daemon enable sshd && \
    daemon start sshd && \
    tmpl sshd_config /etc/ssh/sshd_config sshd
}
