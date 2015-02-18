tunneler_role() {
  usr add -u tunneler -g tunneler -s /sbin/nologin &&
    usr sshkey tunneler "$_tunneler_sshkey"
}
