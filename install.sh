#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

# Define Aletheia locations
export ALETHEIA_PATH="$HOME/.local/share/aletheia"
export ALETHEIA_INSTALL="$ALETHEIA_PATH/install"
export ALETHEIA_INSTALL_LOG_FILE="/var/log/aletheia-install.log"
export PATH="$ALETHEIA_PATH/bin:$PATH"

# Install
source "$ALETHEIA_INSTALL/helpers/all.sh"
source "$ALETHEIA_INSTALL/preflight/all.sh"
source "$ALETHEIA_INSTALL/packaging/all.sh"
source "$ALETHEIA_INSTALL/config/all.sh"
source "$ALETHEIA_INSTALL/login/all.sh"
source "$ALETHEIA_INSTALL/post-install/all.sh"
