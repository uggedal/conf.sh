tmpl() {
  local src=$(dirname $0)/templates/$1
  local dest=$2
  local handler=$3
  local tmp=$(mktemp)
  local diff rc

  local tmpl_awk='
BEGIN {
  section_ignore = 0
  buf = ""
}

{
  buf = ""
  parse($0)
  if (!(section_ignore && length(buf) == 0)) {
    print buf
  }
}

function push(chunk) {
  if (!section_ignore) {
    buf = (buf chunk)
  }
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

    if (modifier == "#") {
      key = substr(unprocessed, RSTART+3, RLENGTH-5)
      if (length(ENVIRON[key]) == 0) {
        section_ignore = 1
      }
    } else if (modifier == "/") {
      section_ignore = 0
    } else {
      key = substr(unprocessed, RSTART+2, RLENGTH-4)
      push(ENVIRON[key])
    }
  }
}
'

  trap "rm $tmp" EXIT TERM INT

  awk "$tmpl_awk" $src > $tmp
  diff=$(diff -u $dest $tmp)

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
