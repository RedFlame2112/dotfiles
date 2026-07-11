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
  neovim
  git
  go

  # System utilities
  fastfetch
  htop
  rofi

]
