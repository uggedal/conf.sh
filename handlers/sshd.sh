#!/bin/sh

action=$1
state=$2
object=$3

[ "$action" = tmpl -a "$state" = changed ] && \
  [ "$object" = /etc/ssh/sshd_config ] && \
  daemon restart sshd
