os() {
  for name in alpine arch; do
    [ -f /etc/${name}-release ] && {
      printf '%s' $name
      break
    }
  done
}
