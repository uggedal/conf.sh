#!/bin/sh

set -e

pkg bash bash-completion@testing vim less
pkg tmux tmux-bash-completion
pkg git git-bash-completion hub ghi mercurial
pkg htop lsof
