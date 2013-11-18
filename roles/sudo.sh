#!/bin/sh

. lib/sys.sh

pkg sudo

tmpl templates/sudoers /etc/sudoers
