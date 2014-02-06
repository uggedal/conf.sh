development_role() {
  pkg accept =dev-vcs/hub-1.11.1 ~amd64
  pkg accept =dev-util/ghi-0.9.1 ~amd64
  pkg accept =dev-util/clib-9999 ~amd64
  pkg accept =dev-util/cloc-1.60 ~amd64

  pkg world \
    app-editors/vim \
    app-misc/tmux \
    dev-vcs/git \
    dev-vcs/hub \
    dev-util/ghi \
    app-shells/bash-completion \
    sys-fs/inotify-tools \
    sys-fs/ncdu \
    sys-process/htop \
    sys-process/lsof \
    sys-devel/bc \
    sys-devel/gdb \
    dev-util/valgrind \
    dev-util/cloc \
    dev-util/clib

  for target in base coreutils man gentoo ssh tmux git;do
    [ -h /etc/bash_completion.d/$target ] \
      || eselect bashcomp enable --global $target
  done

  pkg select editor /usr/bin/vi
}
