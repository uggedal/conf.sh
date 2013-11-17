#!/bin/sh

. lib/sys.sh

pkg alpine-sdk

tmpl templates/abuild.conf /etc/abuild.conf
