miniflux_role() {
  pkg add miniflux &&
    usr groups nginx miniflux
}
