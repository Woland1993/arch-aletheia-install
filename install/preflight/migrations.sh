ALETHEIA_MIGRATIONS_STATE_PATH=~/.local/state/aletheia/migrations
mkdir -p $ALETHEIA_MIGRATIONS_STATE_PATH

for file in ~/.local/share/aletheia/migrations/*.sh; do
  [[ -e $file ]] || continue
  touch "$ALETHEIA_MIGRATIONS_STATE_PATH/$(basename "$file")"
done
