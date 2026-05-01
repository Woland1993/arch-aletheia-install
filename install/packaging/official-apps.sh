install_official_app() {
  local name="$1"
  local aur_packages="$2"
  shift 2

  echo "Installing $name from official source..."
  if "$@"; then
    return 0
  fi

  if aur_helper=$(aletheia-pkg-aur-helper 2>/dev/null); then
    echo "Official install failed, falling back to AUR for $name..."
    aletheia-pkg-aur-add $aur_packages
    return 0
  fi

  echo "Skipping $name: official installer failed and no AUR helper was found."
}

install_official_app "1Password" "1password-beta 1password-cli" aletheia-install-1password
install_official_app "LocalSend" "localsend" aletheia-install-localsend
install_official_app "Typora" "typora" aletheia-install-typora
install_official_app "Pinta" "pinta" aletheia-install-pinta
install_official_app "TerminalTextEffects" "python-terminaltexteffects" aletheia-install-terminaltexteffects

echo "Spotify was not installed automatically: Spotify's official Linux packages are not native Arch packages."
