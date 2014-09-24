shell_role() {
  tmpl -s /root/.bash_profile &&
    tmpl -s /root/.bashrc
}
