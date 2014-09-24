sshd_role() {
  pkg add openssh-server &&
    daemon enable sshd
    tmpl -s /etc/ssh/sshd_config -h sshd
}
