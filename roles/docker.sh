docker_role() {
  pkg add docker &&
    tmpl confd.docker /etc/conf.d/docker docker
    daemon enable docker && \
    daemon start docker
}
