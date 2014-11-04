sshd_role() {
  pkg add openssh &&
    daemon enable sshd
    tmpl -s /etc/ssh/sshd_config -h sshd
}
