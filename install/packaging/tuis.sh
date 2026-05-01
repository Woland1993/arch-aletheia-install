ICON_DIR="$HOME/.local/share/applications/icons"

aletheia-tui-install "Disk Usage" "bash -c 'dust -r; read -n 1 -s'" float "$ICON_DIR/Disk Usage.png"
aletheia-tui-install "Docker" "lazydocker" tile "$ICON_DIR/Docker.png"
