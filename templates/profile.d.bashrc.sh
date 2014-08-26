[ -z "$BASH_VERSION" -o -z "$PS1" ] && return

bind 'set echo-control-characters off'
bind 'set show-all-if-ambiguous on'
bind 'set match-hidden-files off'
bind 'set completion-query-items -1'
bind 'set completion-display-width 0'
bind 'set skip-completed-text on'
bind 'set editing-mode vi'
bind 'set keymap vi-insert' '"\C-l":clear-screen'
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'_prompt_status=$?'

_ok_status() {
  local rc=$_prompt_status
  unset _prompt_status
  [ $rc -eq 0 -o $rc -eq 130 ]
}

PS1='$(_ok_status || printf "\[\e[31m\]")\h \w\[\e[0m\] '
