sshd_role() {
  daemon enable sshd
  tmpl sshd_config /etc/ssh/sshd_config sshd
}
