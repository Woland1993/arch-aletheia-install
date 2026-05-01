# Install all base packages
mapfile -t packages < <(grep -v '^#' "$ALETHEIA_INSTALL/aletheia-base.packages" | grep -v '^$')
aletheia-pkg-add "${packages[@]}"
