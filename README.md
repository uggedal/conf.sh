conf
====

Zero dependency configuration management for
[uggedal.com](http://uggedal.com) machines
in POSIX shell.

The configuration is specific for [Alpine Linux][alpine] systems.

Usage
-----

First you need one or more env files providing at least the `host` and
`roles` of a machine:

```
EOF > myhost.sh
host=192.168.1.125
roles='ssh dns http'
EOF
```

Related
-------

* [Configuration management for POSIX-based systems][posix_cm]
* [cdist][]

License
-------

MIT

[alpine]: http://alpinelinux.org/
[posix_cm]: http://www.webprojekty.cz/ccx/wobsite/article/posix_cm.html
[cdist]: http://www.nico.schottelius.org/software/cdist/
