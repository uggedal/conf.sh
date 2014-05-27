uwsgi_role() {
  pkg add uwsgi uwsgi-python &&
    inode dir /var/log/uwsgi 755 root &&
    tmpl conf.d.uwsgi /etc/conf.d/uwsgi uwsgi &&
    daemon enable uwsgi &&
    daemon start uwsgi
}
