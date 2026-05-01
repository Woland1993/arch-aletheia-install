if command -v aletheia-nvim-setup &>/dev/null; then
  aletheia-nvim-setup
else
  mkdir -p ~/.config/nvim
  cp -a "$ALETHEIA_PATH/config/nvim/." ~/.config/nvim/
fi
