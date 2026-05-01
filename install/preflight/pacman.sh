if [[ -n ${ALETHEIA_ONLINE_INSTALL:-} ]]; then
  sudo pacman -Sy
  aletheia-pkg-add base-devel
fi
