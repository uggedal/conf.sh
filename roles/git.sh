_git_stamp() {
  local repo=$1

  GIT_DIR=$repo git log -1 --format=%ai 2>/dev/null | awk '{ print $1, $2 }'
}

git_role() {
  local name repo visibility section description stamp
  local root=/var/lib/git
  local git_init='sudo -u git git init -q --bare --shared=group'

  pkg add git

  inode dir /etc/sv/git-daemon &&
    inode file /etc/sv/git-daemon/run 755 &&
    tmpl -s /etc/sv/git-daemon/run &&
    inode link /run/runit/supervise.git-daemon /etc/sv/git-daemon/supervise &&
    daemon enable git-daemon

  usr add -S -u git -g git -h $root -s /sbin/nologin

  for i in $(seq -w 1 99); do
    name=$(var get git $i name)
    description="$(var get git $i description)"
    visibility="$(var get git $i visibility)"
    section="$(var get git $i section)"
    repo=$root/$visibility
    [ -n "$section" ] && repo=$repo/$section
    repo=$repo/$name

    [ -z "$name" ] && return
    [ -z "$visibility" ] && return 1

    inode dir $root/$visibility 755 git || return 1

    [ -f $repo/HEAD ] ||
      progress wrap "git $visibility" $name "$git_init $repo"

    [ "$visibility" = public ] && inode file $repo/git-daemon-export-ok 640 git

    printf '%s\n' "$description" > $repo/description

    stamp="$(_git_stamp $repo)"
    [ -z "$stamp" ] || touch -d "$stamp" $repo/refs/heads/master
  done
}
