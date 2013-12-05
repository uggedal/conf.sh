tmpl() {
  local src=$(dirname $0)/templates/$1
  local dest=$2
  local handler=$3
  local tmp=$(mktemp)
  local diff rc

  local tmpl_awk='
{
  print substitute($0)
}

function substitute(raw) {
  if (match(raw, /\{\{([^}]*)\}\}/)) {
    tag = substr(raw, RSTART, RLENGTH)
    key = substr(raw, RSTART+2, RLENGTH-4)
    gsub(tag, ENVIRON[key], raw)
    return substitute(raw)
  } else {
    return raw
  }
}
'

  trap "rm $tmp" EXIT TERM INT

  awk "$tmpl_awk" $src > $tmp
  diff=$(diff $dest $tmp)

  [ $? -eq 0 ] && return

  progress start tmpl $dest

  cat $tmp > $dest
  rc=$?

  progress finish $rc

  [ $rc -eq 0 ] || {
    progress result "$diff"
    return
  }

  progress result "$diff"

  [ -z "$handler" ] || notify $handler tmpl changed $dest
}
