_md5() {
  md5sum $1 | awk '{ print $1 }'
}

file() {
  local src=$(dirname $0)/files/$1
  local dest=$2

  [ -f $dest ] && [ "$(_md5 $src)" = "$(_md5 $dest)" ] && return

  progress wrap file $dest "cp $src $dest"
}
