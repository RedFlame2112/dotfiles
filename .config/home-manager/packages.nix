{ pkgs, config, ... }:

with pkgs;

[
  # Shell utilities
  zsh
  fzf
  bat
  eza
  fd
  ripgrep
  zoxide
  direnv
  gum

  # Persistent terminal sessions and terminal workflows
  tmux
  lazygit
  delta
  yazi

  # Friendly command-line utilities
  jq
  yq-go
  tealdeer
  dust
  duf
  procs
  just
  watchexec

  # Shell development and dotfile validation
  shellcheck
  shfmt

  # Development tools
  # Neovim is provided by pacman so its runtime stays aligned with this
  # Arch-focused configuration; do not shadow it with the Nix profile copy.
  git
  go

  # System utilities
  fastfetch
  htop
  rofi

]
