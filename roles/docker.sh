docker_role() {
  pkg add docker &&
    daemon enable docker && \
    daemon start docker
}
