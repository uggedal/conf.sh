result() {
  if [ $1 -eq 0 ]; then
    printf ' \e[32m✓'
  else
    printf ' \e[31m✗'
  fi
  printf '\e[0m\n'
}

verbose() {
  printf '%s\n' "$1" | sed 's/^/  /'
}

name() {
  printf '%s \e[33m%s\e[0m' $1 $2
}

pkg() {
  local err
  for p do
    apk info --quiet --installed $p || {
      name pkg $p
      err=$(apk add --quiet $p 2>&1)
      result $?
      [ -z "$err" ] || verbose "$err"
    }
  done
}

tmpl() {
  local src=$1
  local dest=$2
  local tmp=$(mktemp)
  local diff

  trap 'rm $tmp' 1 2 3 15

  ./lib/tmpl.awk $src > $tmp
  diff=$(diff $tmp $dest)

  [ $? -eq 0 ] && return

  name tmpl $dest

  cat $tmp > $dest
  result $?
  verbose "$diff"
}
