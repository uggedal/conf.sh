sshd_role() {
  pkg add openssh-server &&
    daemon enable sshd
    tmpl ssh.sshd_config /etc/ssh/sshd_config sshd
}
