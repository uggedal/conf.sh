_git_var() {
  eval printf '%s' \"\$_git_${1}_${2}\"
}

_has_id() {
  cut -d: -f1 /etc/$1 | fgrep -q $2
}

_git_stamp() {
  GIT_DIR=$repo git log -1 --format=%ai 2>/dev/null | awk '{ print $1, $2 }'
}

git_role() {
  local name repo visibility description stamp
  local root=/var/lib/git

  pkg add git

  _has_id group git || addgroup -S git
  _has_id passwd git || adduser -SDH -G git -h $root -s /sbin/nologin git

  for i in $(seq -w 1 99); do
    name=$(_git_var $i name)
    description="$(_git_var $i description)"
    visibility="$(_git_var $i visibility)"
    repo=$root/$visibility/$name

    [ -z "$name" ] && return
    [ -z "$visibility" ] && return 1

    inode dir $root/$visibility 755 git || return 1

    [ -f $repo/HEAD ] ||
      sudo -u git git init --bare --shared=group $repo

    printf '%s\n' "$description" > $repo/description

    stamp="$(_git_stamp)"
    [ -z "$stamp" ] || touch -d "$stamp" $repo/refs/heads/master
  done
}
