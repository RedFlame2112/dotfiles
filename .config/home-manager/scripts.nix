{ pkgs, ... }:

with pkgs;

[
  # System Info Script
  (writeShellScriptBin "sysinfo" ''
    exec ${fastfetch}/bin/fastfetch
  '')

  # Backup Configs Script
  (writeShellScriptBin "backup-configs" ''
    set -eu
    destination="$HOME/cfg_backups"
    mkdir -p "$destination"
    archive="$destination/dotfiles-$(date +%F-%H%M%S).tar.gz"
    ${gnutar}/bin/tar -czf "$archive" \
      -C "$HOME" \
      .zshrc .zshenv .gitconfig \
      .config/home-manager .config/hypr .config/kitty \
      .config/waybar .config/dunst .config/rofi .config/swaylock
    printf 'Backup written to %s\n' "$archive"
  '')

]
