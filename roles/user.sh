user_role() {
  pkg add bash && \
    usr add $_user_name $_user_group /bin/bash && \
    usr unlock $_user_name && \
    usr groups $_user_name "$_user_groups" && \
    usr sshkey $_user_name "$_user_sshkey"
}
