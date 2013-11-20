#!/bin/sh

set -e

pkg openssh

tmpl sshd_config /etc/ssh/sshd_config sshd

[ "$state" = changed ] && daemon restart sshd
