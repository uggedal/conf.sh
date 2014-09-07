shell_role() {
  tmpl root.bash_profile /root/.bash_profile &&
    tmpl root.bashrc /root/.bashrc
}
