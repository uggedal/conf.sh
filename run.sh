#!/bin/sh

[ $# -eq 1 ] || {
  printf '%s: <host>\n' $0
  exit 64
}

user=${user:-root}
host=$1
repo=$(basename $(dirname $(readlink -f $0)))

(
  cd ..
  tar cpf - $repo | ssh $user@$host "tar xpf - -C /tmp"
)

# TODO: lookup roles per host and run them all:
ssh $user@$host "cd /tmp/$repo && sh roles/development.sh"
