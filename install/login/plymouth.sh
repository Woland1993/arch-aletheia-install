if [[ $(plymouth-set-default-theme) != "aletheia" ]]; then
  sudo cp -r "$HOME/.local/share/aletheia/default/plymouth" /usr/share/plymouth/themes/aletheia/
  sudo plymouth-set-default-theme aletheia
fi
