conf
====

Zero dependency configuration management for
Void Linux machines in POSIX shell.

Usage
-----

First you need one or more env files providing at least the host and
roles of a machine:

    cat <<EOF > myhost.sh
    host=192.168.1.125
    roles='ssh dns http'
    EOF

Then you push your configuration with:

    ./push myhost.sh

Related
-------

* [Configuration management for POSIX-based systems][posix_cm]
* [cdist][]

License
-------

ISC
