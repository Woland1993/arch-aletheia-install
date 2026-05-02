set -e

if aletheia-pkg-aur-helper >/dev/null 2>&1; then
  exit 0
fi

echo "Installing yay so AUR packages can be built from upstream PKGBUILDs..."
aletheia-pkg-aur-helper --install
