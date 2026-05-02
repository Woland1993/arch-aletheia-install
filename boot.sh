#!/bin/bash

set -eEo pipefail

# Set install mode to online since boot.sh is used for curl installations
export ALETHEIA_ONLINE_INSTALL=true

ansi_art='
       ▄▄      ▄▄▄▄▄▄      ▄▄▄▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄▄▄▄▄▄ ▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄      ▄▄
      ████      ███         ███     ▀ █   ████   █  ███     ███    ███     ▀   ███       ████
     ▄█████     ███         ███   ▄▄      ████      ███     ███    ███   ▄▄    ███      ▄█████
    ▄█  ███▄    ███         ███▀▀▀██      ████      ███▀▀▀▀▀███    ███▀▀▀██    ███     ▄█  ███▄
    ██▄▄▄███▄   ███         ███           ████      ███     ███    ███         ███     ██▄▄▄███▄
   █▀    ▀███   ███     █   ███     ▄▄    ████      ███     ███    ███     ▄▄  ███    █▀    ▀███
  ▀▀▀▀   ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀   ▀▀▀▀▀▀    ▀▀▀▀▀▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀▀ ▀▀▀▀▀▀ ▀▀▀▀   ▀▀▀▀▀▀'

clear
echo -e "\n$ansi_art\n"

# Use custom branch if instructed, otherwise default to master
ALETHEIA_REF="${ALETHEIA_REF:-master}"

sudo pacman -Syu --noconfirm --needed git

if [[ -z ${ALETHEIA_REPO:-} ]]; then
  echo "Set ALETHEIA_REPO to your repo, e.g. owner/aletheia"
  exit 1
fi

case "$ALETHEIA_REPO" in
http://* | https://* | git@* | ssh://* | file://* | /* | ./* | ../*)
  clone_url="$ALETHEIA_REPO"
  ;;
*)
  clone_url="https://github.com/${ALETHEIA_REPO%.git}.git"
  ;;
esac

target_dir="$HOME/.local/share/aletheia"
mkdir -p "$HOME/.local/share"
tmp_dir=$(mktemp -d "$HOME/.local/share/aletheia.XXXXXX")
trap 'rm -rf "$tmp_dir"' EXIT

echo -e "\nCloning Aletheia from: $clone_url"
git clone "$clone_url" "$tmp_dir"

echo -e "\e[32mUsing branch: $ALETHEIA_REF\e[0m"
cd "$tmp_dir"
git fetch origin "${ALETHEIA_REF}" && git checkout "${ALETHEIA_REF}"
cd -

if [[ ! -f "$tmp_dir/install.sh" ]]; then
  echo "Error: install.sh was not found at the root of $clone_url on ref $ALETHEIA_REF." >&2
  echo "Check ALETHEIA_REPO and ALETHEIA_REF." >&2
  exit 1
fi

rm -rf "$target_dir"
mv "$tmp_dir" "$target_dir"
trap - EXIT

echo -e "\nInstallation starting..."
source "$target_dir/install.sh"
