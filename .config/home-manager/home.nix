{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "quaternion2112";
  home.homeDirectory = "/home/quaternion2112";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

  #### This section is to help automate my pacman package synchronization by using HM as a hook:


  ## My packages are with different packages script files
  home.packages =
    (import ./packages.nix { inherit pkgs config; })
    ++ (import ./scripts.nix { inherit pkgs; });

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {

    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    
#    ".zshrc" = {
#      source = "${config.home.homeDirectory}/.zshrc";
#    };

  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/quaternion2112/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.tmux = {
    enable = true;
    prefix = "C-a";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 100000;
    keyMode = "vi";
    mouse = true;
    terminal = "tmux-256color";
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      resurrect
      continuum
    ];
    extraConfig = ''
      set -g renumber-windows on
      set -g set-clipboard on
      set -ag terminal-overrides ',xterm-kitty:RGB'

      # New panes and windows stay in the current working directory.
      bind c new-window -c '#{pane_current_path}'
      bind '|' split-window -h -c '#{pane_current_path}'
      bind '-' split-window -v -c '#{pane_current_path}'

      # Vim-style pane movement without needing the prefix repeatedly.
      bind -r h select-pane -L
      bind -r j select-pane -D
      bind -r k select-pane -U
      bind -r l select-pane -R

      # Silver Wolf-inspired status line.
      set -g status-position bottom
      set -g status-style 'bg=#11111b,fg=#cdd6f4'
      set -g status-left '#[bg=#89b4fa,fg=#11111b,bold]  #S  '
      set -g status-right '#[fg=#cba6f7]#H #[fg=#89b4fa]%Y-%m-%d %H:%M '
      set -g window-status-current-format '#[bg=#cba6f7,fg=#11111b,bold] #I:#W '

      set -g @resurrect-capture-pane-contents 'on'
      set -g @continuum-restore 'on'
      set -g @continuum-save-interval '15'
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
