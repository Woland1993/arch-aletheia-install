# Place in ~/.claude/skills since all tools populate from there as well as their own sources
mkdir -p ~/.claude/skills
ln -s $ALETHEIA_PATH/default/aletheia-skill ~/.claude/skills/aletheia
