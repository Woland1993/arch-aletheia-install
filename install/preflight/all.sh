source $ALETHEIA_INSTALL/preflight/guard.sh
source $ALETHEIA_INSTALL/preflight/begin.sh
run_logged $ALETHEIA_INSTALL/preflight/show-env.sh
run_logged $ALETHEIA_INSTALL/preflight/pacman.sh
run_logged $ALETHEIA_INSTALL/preflight/migrations.sh
run_logged $ALETHEIA_INSTALL/preflight/first-run-mode.sh
run_logged $ALETHEIA_INSTALL/preflight/disable-mkinitcpio.sh
