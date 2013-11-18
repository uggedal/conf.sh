#!/bin/sh

[ $# -eq 2 ] || {
  printf '%s: <host> <env>\n' $0
  exit 64
}

user=${user:-root}
host=$1
env=$(readlink -f $2)
repo=$(basename $(dirname $(readlink -f $0)))
dest=/tmp/$repo

roles() {
  . $env
  for role in $roles; do
    printf ' && %s/roles/%s.sh' $dest $role
  done
}

exported() {
  sed -e '/^[^_]/d' -e 's/^/export /' < $env
}

(
  cd ..
  tar cpf - $repo | ssh $user@$host "tar xpf - -C $(dirname $dest)"
)

ssh $user@$host "PATH=$dest/bin:\"\$PATH\" $(exported)$(roles)"
