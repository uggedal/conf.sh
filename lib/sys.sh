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

pkg() {
  local err
  for p do
    case $os in
      alpine)
        apk info --quiet --installed $p || {
          printf 'pkg %s' $p
          err=$(apk add --quiet $p 2>&1)
          result $?
          [ -z "$err" ] || printf '%s\n' "$err" | sed 's/^/  /'
        }
        ;;
    esac
  done
}
