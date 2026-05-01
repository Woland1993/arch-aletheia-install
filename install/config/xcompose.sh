# Set default XCompose that is triggered with CapsLock
tee ~/.XCompose >/dev/null <<EOF
# Run aletheia-restart-xcompose to apply changes

# Include fast emoji access
include "%H/.local/share/aletheia/default/xcompose"

# Identification
<Multi_key> <space> <n> : "$ALETHEIA_USER_NAME"
<Multi_key> <space> <e> : "$ALETHEIA_USER_EMAIL"
EOF
