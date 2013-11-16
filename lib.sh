_os() {
  for name do
    if [ -f /etc/${name}-release ]; then
      printf '%s' $name
      break
    fi
  done
}

os=$(_os alpine arch)

pkg() {
  for p do
    case $os in
      alpine)
        apk info -e $p || apk add $p
        ;;
    esac
    :
  done
}
