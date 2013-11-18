#!/bin/sh

id $_user_name >/dev/null 2>&1 || adduser -D -s $_user_shell -G $_user_group $_user_name
for g in $_user_groups; do
  id -nG $_user_name | grep -q $g || addgroup $_user_name $g
done
