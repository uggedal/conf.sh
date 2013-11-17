#!/bin/sh

[ $# -eq 2 ] || {
  printf '%s: <host> <environment>\n' $0
  exit 64
}

user=${user:-root}
host=$1
environment=$(readlink -f $2)
repo=$(basename $(dirname $(readlink -f $0)))

roles() {
  . $environment
  for role in $roles; do
    printf '&& ./roles/%s.sh' $role
  done
}

(
  cd ..
  tar cpf - $repo | ssh $user@$host "tar xpf - -C /tmp"
)

ssh $user@$host "$(cat $environment) && cd /tmp/$repo $(roles)"
