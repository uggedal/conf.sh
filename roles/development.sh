development_role() {
  pkg accept =dev-vcs/hub-1.11.0 ~amd64

  pkg world \
    app-editors/vim \
    app-misc/tmux \
    dev-vcs/git \
    dev-vcs/hub \
    app-shells/bash-completion \
    sys-process/htop \
    sys-process/lsof \
    sys-devel/bc

  for target in base coreutils man gentoo ssh tmux git;do
    [ -h /etc/bash_completion.d/$target ] \
      || eselect bashcomp enable --global $target
  done

  pkg select editor /usr/bin/vi
}
