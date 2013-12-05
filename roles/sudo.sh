sudo_role() {
  pkg sudo && \

  tmpl sudoers /etc/sudoers
}
