_pkg_world() {
  local worldfile=/var/lib/portage/world
  local exists

  for p do
    grep -q "^$p\$" $worldfile || {
      progress start pkg $p world
      printf "$p\n" >> $worldfile
      progress finish 0
    }
  done

  for p do
    stat -t /var/db/pkg/$p-* >/dev/null 2>&1 || {
      progress start pkg $p exists
      progress finish 1
      return 1
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

_pkg_select() {
  local module=$1
  local choice=$2
  local activation
  local flags

  case $module in
    bashcomp)
      [ -h /etc/bash_completion.d/$choice ] && return
      activation=enable
      flags='--global'
      ;;
    *)
      eselect $module show | tail -n1 | \
        sed 's/^ *//;s/ *$//' | grep -q "^$choice\$" && return
      activation=set
      ;;
  esac

  progress start pkg "$module $choice" select
  eselect $module $activation $flags $choice
  progress finish $?
}

pkg() {
  action=$1
  shift

  _pkg_$action "$@"
}
