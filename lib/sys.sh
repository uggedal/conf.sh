_os() {
  for name do
    if [ -f /etc/${name}-release ]; then
      printf '%s' $name
      break
    fi
  done
}

os=$(_os alpine arch)

result() {
  if [ $1 -eq 0 ]; then
    printf ' \e[32m✓'
  else
    printf ' \e[31m✗'
  fi
  printf '\e[0m\n'
}

name() {
  printf '%s \e[33m%s\e[0m' $1 $2
}

pkg() {
  local err
  for p do
    case $os in
      alpine)
        apk info --quiet --installed $p || {
          name pkg $p
          err=$(apk add --quiet $p 2>&1)
          result $?
          [ -z "$err" ] || printf '%s\n' "$err" | sed 's/^/  /'
        }
        ;;
    esac
  done
}

tmpl() {
  ./lib/tmpl.awk $1
}
