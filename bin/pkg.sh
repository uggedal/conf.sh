_pkg_world() {
  local worldfile=/var/lib/portage/world

  for p do
    grep -q "^$p\$" $worldfile || {
      progress start pkg $p world
      printf "$p\n" >> $worldfile
      progress finish 0
    }
  done
}

_pkg_accept() {
  local line
  line="$1 $2"
  local acceptfile=/etc/portage/package.accept_keywords

  grep -q "^$line\$" $acceptfile 2>/dev/null|| {
    progress start pkg "$line" accept
    printf "$line\n" >> $acceptfile
    progress finish 0
  }
}

_pkg_use() {
  local line
  line="$1"
  shift
  line="$line $*"

  local usefile=/etc/portage/package.use

  grep -q "^$line\$" $usefile 2>/dev/null || {
    progress start pkg "$line" use
    printf "$line\n" >> $usefile
    progress finish 0
  }
}

pkg() {
  action=$1
  shift

  _pkg_$action "$@"
}
