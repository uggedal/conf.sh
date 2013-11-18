#!/bin/sh

set -e

pkg openssh

# TODO: this is ugly:
set +e
tmpl sshd_config /etc/ssh/sshd_config
set -e

if  [ $? -eq 100 ]; then
  daemon restart sshd
fi
