# Overwrite parts of the aletheia-menu with user-specific submenus.
# See $ALETHEIA_PATH/bin/aletheia-menu for functions that can be overwritten.
#
# WARNING: Overwritten functions will obviously not be updated when Aletheia changes.
#
# Example of minimal system menu:
#
# show_system_menu() {
#   case $(menu "System" "  Lock\n󰐥  Shutdown") in
#   *Lock*) aletheia-lock-screen ;;
#   *Shutdown*) aletheia-system-shutdown ;;
#   *) back_to show_main_menu ;;
#   esac
# }
#
# Example of overriding just the about menu action: (Using zsh instead of bash (default))
#
# show_about() {
#   exec aletheia-launch-or-focus-tui "zsh -c 'fastfetch; read -k 1'"
# }
