user_role() {
  pkg add bash && \
    usr add $_user_name $_user_group /bin/bash && \
    usr groups $_user_name "$_user_groups"
}
