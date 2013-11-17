conf
====

Zero dependency configuration management for
[uggedal.com](http://uggedal.com) machines
in POSIX shell.

The configuration is specific for [Alpine Linux][alpine] systems.

Usage
-----

```sh
cat <<EOF > myhost.sh
roles='development packaging'
name='Your name'
email=you@name.com
EOF

./run.sh myhost mybox.sh
```

Related
-------

* [Configuration management for POSIX-based systems][posix_cm]

License
-------

MIT

[alpine]: http://alpinelinux.org/
[posix_cm]: http://www.webprojekty.cz/ccx/wobsite/article/posix_cm.html
