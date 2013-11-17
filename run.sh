#!/bin/sh

[ $# -eq 2 ] || {
  printf '%s: <host> <environment>\n' $0
  exit 64
}

user=${user:-root}
host=$1
environment=$(cat $2)
repo=$(basename $(dirname $(readlink -f $0)))

(
  cd ..
  tar cpf - $repo | ssh $user@$host "tar xpf - -C /tmp"
)

# TODO: lookup roles per host and run them all:
ssh $user@$host "$environment && cd /tmp/$repo && ./roles/development.sh"
