#!/bin/bash

if ! command -v walker &>/dev/null; then
  echo "Skipping Walker setup: walker is not installed"
  exit 0
fi

# Ensure Walker service is started automatically on boot
mkdir -p ~/.config/autostart/
cp $ALETHEIA_PATH/default/walker/walker.desktop ~/.config/autostart/

# And is restarted if it crashes or is killed
mkdir -p ~/.config/systemd/user/app-walker@autostart.service.d/
cp $ALETHEIA_PATH/default/walker/restart.conf ~/.config/systemd/user/app-walker@autostart.service.d/restart.conf

# Create pacman hook to restart walker after updates
sudo mkdir -p /etc/pacman.d/hooks
sudo tee /etc/pacman.d/hooks/walker-restart.hook > /dev/null << EOF
[Trigger]
Type = Package
Operation = Upgrade
Target = walker
Target = walker-debug
Target = elephant*

[Action]
Description = Restarting Walker services after system update
When = PostTransaction
Exec = $ALETHEIA_PATH/bin/aletheia-restart-walker
EOF

# Link the visual theme menu config
if command -v elephant &>/dev/null; then
  mkdir -p ~/.config/elephant/menus
  ln -snf $ALETHEIA_PATH/default/elephant/aletheia_themes.lua ~/.config/elephant/menus/aletheia_themes.lua
  ln -snf $ALETHEIA_PATH/default/elephant/aletheia_background_selector.lua ~/.config/elephant/menus/aletheia_background_selector.lua
fi
