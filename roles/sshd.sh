#!/bin/sh

pkg openssh && \
tmpl sshd_config /etc/ssh/sshd_config

[ $? -eq 100 ] && daemon restart sshd
