{ pkgs, config, ... }:

with pkgs;

[
  # Shell utilities
  zsh
  fzf
  bat
  eza

  # Development tools
  neovim
  git
  go

  # System utilities
  fastfetch
  htop
  rofi

]
