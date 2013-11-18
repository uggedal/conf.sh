#!/bin/sh

[ $# -eq 1 ] || {
  printf '%s: <env>\n' $0
  exit 64
}

env=$(readlink -f $1)

. $env

[ -n "$host" ] || {
  printf 'no host in %s\n' $env
  exit 64
}

[ -n "$roles" ] || {
  printf 'no roles in %s\n' $env
  exit 64
}

user=${user:-root}
repo=$(basename $(dirname $(readlink -f $0)))
dest=/tmp/$repo

roles() {
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

ssh $user@$host PATH=$dest/bin:'"$PATH"'" $(exported)$(roles)"
