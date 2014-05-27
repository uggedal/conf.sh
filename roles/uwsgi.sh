uwsgi_role() {
  pkg add uwsgi uwsgi-python &&
    tmpl conf.d.uwsgi /etc/conf.d/uwsgi uwsgi &&
    daemon enable uwsgi &&
    daemon start uwsgi
}
