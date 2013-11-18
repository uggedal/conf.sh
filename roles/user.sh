#!/bin/sh

id $user >/dev/null 2>&1 || adduser -D -s $shell -G $group $user
for g in $groups; do
  id -nG $user | grep -q $g || addgroup $user $g
done
