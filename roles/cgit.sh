cgit_role() {
  local logo_src=$(dirname $0)/files/git.uggedal.com.png
  local logo_dest=/usr/share/webapps/cgit/$(basename $logo_src)
  pkg add cgit py-pygments

  [ -f $logo_dest ] || cp $logo_src $logo_dest

  tmpl cgitrc /etc/cgitrc
}
