_git_var() {
  eval printf '%s' \"\$_git_${1}_${2}\"
}

_has_id() {
  cut -d: -f1 /etc/$1 | fgrep -q $2
}

git_role() {
  local name description
  local root=/var/lib/git

  pkg add git

  _has_id group git || addgroup -S git
  _has_id passwd git || adduser -SDH -G git -h $root -s /sbin/nologin git

  inode dir $root 755 git || return 1

  for i in $(seq -w 1 99); do
    name=$(_git_var $i name)
    description="$(_git_var $i description)"

    [ -z "$name" ] && return

    [ -f $root/$name/HEAD ] ||
      sudo -u git git init --bare --shared=group $root/$name

    printf '%s\n' "$description" > $root/$name/description
  done
}
