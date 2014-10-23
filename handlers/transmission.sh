transmission_handler() {
  local kind=$1
  local state=$2
  local file=$3

  pkill -HUP transmission-da
}
