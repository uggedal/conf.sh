conf
====

Zero dependency configuration management for
[Alpine Linux][alpine] machines in POSIX shell.

Usage
-----

First you need one or more env files providing at least the `host` and
`roles` of a machine:

```sh
cat <<EOF > myhost.sh
host=192.168.1.125
roles='ssh dns http'
EOF
```

Then you push your configuration with:

```sh
./push myhost.sh
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
