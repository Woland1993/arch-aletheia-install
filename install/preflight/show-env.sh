# Show installation environment variables
gum log --level info "Installation Environment:"

env | grep -E "^(ALETHEIA_CHROOT_INSTALL|ALETHEIA_ONLINE_INSTALL|ALETHEIA_USER_NAME|ALETHEIA_USER_EMAIL|USER|HOME|ALETHEIA_REPO|ALETHEIA_REF|ALETHEIA_PATH)=" | sort | while IFS= read -r var; do
  gum log --level info "  $var"
done
