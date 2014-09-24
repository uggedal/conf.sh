cgit_role() {
  local md_dest=/usr/lib/cgit/filters/md.py
  local highlight_dest=/usr/lib/cgit/filters/highlight.py

  pkg add cgit python-Pygments python-hoedown

  file cgit.md.filter.py $md_dest
  inode file $md_dest 755

  file cgit.highlight.filter.py $highlight_dest
  inode file $highlight_dest 755

  file git.uggedal.com.png /usr/share/webapps/cgit/git.uggedal.com.png

  tmpl -s /etc/cgitrc
}
