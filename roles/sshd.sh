sshd_role() {
  pkg openssh && \

  tmpl sshd_config /etc/ssh/sshd_config sshd
}
