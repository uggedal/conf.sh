pkg() {
  local err rc
  for p do
    case $(os) in
      alpine)
        apk info --quiet --installed $p || {
          progress start pkg $p
          err=$(apk add --quiet $p 2>&1)
          rc=$?
          progress finish $rc
          [ -z "$err" ] || progress result "$err"
          [ $rc -eq 0 ] || return $rc
        }
        ;;
    esac
  done
}
