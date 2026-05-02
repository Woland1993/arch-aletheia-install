set -e

install_official_app() {
  local name="$1"
  local aur_packages="$2"
  shift 2

  echo "Installing $name..."
  if "$@"; then
    return 0
  fi

  echo "$name direct installer failed, falling back to AUR..."
  aletheia-pkg-aur-add $aur_packages
}

install_official_app "1Password" "1password-beta 1password-cli" aletheia-install-1password
install_official_app "LocalSend" "localsend" aletheia-install-localsend
install_official_app "Typora" "typora" aletheia-install-typora
install_official_app "Pinta" "pinta" aletheia-install-pinta
install_official_app "TerminalTextEffects" "python-terminaltexteffects" aletheia-install-terminaltexteffects
echo "Installing Spotify..."
aletheia-install-spotify
