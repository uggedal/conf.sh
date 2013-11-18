#!/bin/sh

. lib/sys.sh

pkg alpine-sdk git-perl

tmpl templates/abuild.conf /etc/abuild.conf
