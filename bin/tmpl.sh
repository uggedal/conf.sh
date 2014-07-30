tmpl() {
  local src=$(dirname $0)/templates/$1
  local dest=$2
  local handler=$3
  local tmp=$(mktemp)
  local diff rc

  local tmpl_awk='
BEGIN {
  split("", ignores)
}

{
  buf = ""
  parse($0)
  if (!length(ignores)) {
    print buf
  }
}

function push(chunk) {
  if (!length(ignores)) {
    buf = (buf chunk)
  }
}

function ignore_section(mod, key) {
  len = length(ENVIRON[key])
  return (mod == "#" && len == 0) || (mod == "^" && len != 0)
}

function parse(line) {
  cursor = 1

  while (1) {
    unprocessed = substr(line, cursor)
    has_match = match(unprocessed, /\{\{[^}]*\}\}/)

    if (!has_match) {
      push(unprocessed)
      return
    }

    cursor = cursor + RSTART + RLENGTH - 1
    push(substr(unprocessed, 0, RSTART - 1))

    modifier = substr(unprocessed, RSTART+2, 1)
    key = substr(unprocessed, RSTART+3, RLENGTH-5)

    if (modifier == "#" || modifier == "^") {
      if (ignore_section(modifier, key)) {
        ignores[key] = ""
      }
    } else if (modifier == "/") {
      delete ignores[key]
    } else {
      key = substr(unprocessed, RSTART+2, RLENGTH-4)
      push(ENVIRON[key])
    }

  }
}
'

  awk "$tmpl_awk" $src > $tmp

  [ -f $dest ] || touch $dest

  diff=$(diff -u $dest $tmp) && {
    rm $tmp
    return
  }

  progress start tmpl $dest

  cat $tmp > $dest
  rc=$?

  progress finish $rc

  [ $rc -eq 0 ] || {
    rm $tmp
    return $rc
  }

  progress result "$diff"

  [ -z "$handler" ] || notify $handler tmpl changed $dest

  rm $tmp
}
