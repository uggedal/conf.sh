#!/bin/sh

die() {
  local pattern="$1"
  shift
  printf "$pattern" "$@"
  exit 64
}

[ $# -eq 1 ] || die '%s: <env>\n' $0

env=$(readlink -f $1)

. $env

[ -n "$host" ] || die 'no host in %s\n' $env
[ -n "$roles" ] || die 'no roles in %s\n' $env

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
