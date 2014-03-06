packaging_role() {
  pkg accept =app-portage/gaux-0.1.0 ~amd64

  pkg world app-portage/gentoolkit \
    app-portage/gaux
}
