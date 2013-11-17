#!/usr/bin/awk -f

{
  print substitute($0)
}

function substitute(raw) {
  if (match(raw, /{{([^}]*)}}/)) {
    tag = substr(raw, RSTART, RLENGTH)
    key = substr(raw, RSTART+2, RLENGTH-4)
    gsub(tag, ENVIRON[key], raw)
    return substitute(raw)
  } else {
    return raw
  }
}
