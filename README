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

A more elaborate example:

    cat <<EOF > mysecondhost.sh
    host=192.168.1.126
    port=2222

    roles='
      locale
      nftables
      logrotate
      nginx
      cgi
      cgit
      git
      php
      miniflux
    '

    _locale_name='en_US.UTF-8'
    _locale_charset='UTF-8'

    _nftables_tcp_open='http, 9418'
    _nftables_tcp_limit='ssh'

    _nginx_1_fqdn=uggedal.com
    _nginx_1_aliases='www.uggedal.com ugg.is'
    _nginx_1_subdomain_redirect='journal'

    _nginx_2_fqdn=git.uggedal.com
    _nginx_2_root=/usr/share/webapps/cgit
    _nginx_2_upstream=unix:/run/spawn-fcgi.sock
    _nginx_2_cgi_script=/usr/share/webapps/cgit/cgit.cgi

    _nginx_3_fqdn=feed.uggedal.com
    _nginx_3_root=/usr/share/webapps/miniflux
    _nginx_3_upstream=unix:/run/php-fpm.sock
    _nginx_3_php=true
    _nginx_3_static_prefix=/assets

    _cgi_user=nginx

    _php_fpm_user=nginx
    _php_open_basedir=/tmp/:/usr/share/webapps/:/var/lib/miniflux/
    _php_extension_sqlite=true
    _php_extension_iconv=true

    _git_01_name=todo
    _git_01_visibility=private
    _git_01_description='Todo items'

    _git_02_name=conf
    _git_02_visibility=public
    _git_02_description='Zero dependency configuration management'

    _git_03_name=dotfiles
    _git_03_visibility=public
    _git_03_description='User config for eivind@uggedal.com '
    EOF

License
-------

ISC
