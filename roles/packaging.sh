#!/bin/sh

. lib/sys.sh

pkg alpine-sdk

./lib/tmpl.awk templates/abuild.conf > /etc/abuild.conf
