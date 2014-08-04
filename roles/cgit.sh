cgit_role() {
  local logo_src=$(dirname $0)/files/git.uggedal.com.png
  local logo_dest=/usr/share/webapps/cgit/$(basename $logo_src)
  local highlight_src=$(dirname $0)/files/cgit.highlight.filter.py
  local highlight_dest=/usr/lib/cgit/filters/highlight.py
  local md_src=$(dirname $0)/files/cgit.md.filter.py
  local md_dest=/usr/lib/cgit/filters/md.py

  pkg add cgit py-pygments py-hoedown

  [ -f $md_dest ] || cp $md_src $md_dest
  inode file $md_dest 755

  [ -f $highlight_dest ] || cp $highlight_src $highlight_dest
  inode file $highlight_dest 755

  [ -f $logo_dest ] || cp $logo_src $logo_dest

  tmpl cgitrc /etc/cgitrc
}
