#!/bin/bash

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
  echo "Set ALETHEIA_REPO to your GitHub repo, e.g. owner/aletheia"
  exit 1
fi

echo -e "\nCloning Aletheia from: https://github.com/${ALETHEIA_REPO}.git"
rm -rf ~/.local/share/aletheia/
git clone "https://github.com/${ALETHEIA_REPO}.git" ~/.local/share/aletheia >/dev/null

echo -e "\e[32mUsing branch: $ALETHEIA_REF\e[0m"
cd ~/.local/share/aletheia
git fetch origin "${ALETHEIA_REF}" && git checkout "${ALETHEIA_REF}"
cd -

echo -e "\nInstallation starting..."
source ~/.local/share/aletheia/install.sh
