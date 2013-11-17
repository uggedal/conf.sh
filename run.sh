#!/bin/sh

[ $# -eq 2 ] || {
  printf '%s: <host> <env>\n' $0
  exit 64
}

user=${user:-root}
host=$1
env=$(readlink -f $2)
repo=$(basename $(dirname $(readlink -f $0)))

roles() {
  . $env
  for role in $roles; do
    printf '&& ./roles/%s.sh' $role
  done
}

exported() {
  sed -e '/^$/d' -e 's/^/export /' < $env
}

(
  cd ..
  tar cpf - $repo | ssh $user@$host "tar xpf - -C /tmp"
)

ssh $user@$host "$(exported) && cd /tmp/$repo $(roles)"
