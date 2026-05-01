# Set identification from install inputs
if [[ -n ${ALETHEIA_USER_NAME//[[:space:]]/} ]]; then
  git config --global user.name "$ALETHEIA_USER_NAME"
fi

if [[ -n ${ALETHEIA_USER_EMAIL//[[:space:]]/} ]]; then
  git config --global user.email "$ALETHEIA_USER_EMAIL"
fi
