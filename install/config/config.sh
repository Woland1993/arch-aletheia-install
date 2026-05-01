# Copy over Aletheia configs
mkdir -p ~/.config
cp -R ~/.local/share/aletheia/config/* ~/.config/

# Use default bashrc from Aletheia
cp ~/.local/share/aletheia/default/bashrc ~/.bashrc
