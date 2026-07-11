<div align="center">
  <img src=".github/assets/SW999_Banner.jpg" alt="Silver Wolf LV.999 banner" width="100%" />

  <h1>「 DOTFILES 」</h1>

  <p><em>Reality is just another game.</em></p>

  [![Arch Linux](https://img.shields.io/badge/Arch_Linux-0b1020?style=for-the-badge&logo=archlinux&logoColor=58c7f3)](https://archlinux.org/)
  [![Hyprland](https://img.shields.io/badge/Hyprland-151028?style=for-the-badge&logo=wayland&logoColor=cba6f7)](https://hypr.land/)
  [![Neovim](https://img.shields.io/badge/Neovim-111827?style=for-the-badge&logo=neovim&logoColor=a6e3a1)](https://github.com/RedFlame2112/nvim-config)
  [![Shell](https://img.shields.io/badge/Zsh-171126?style=for-the-badge&logo=gnubash&logoColor=f5c2e7)](https://www.zsh.org/)
  [![Last Commit](https://img.shields.io/github/last-commit/RedFlame2112/dotfiles?style=for-the-badge&color=89b4fa&labelColor=11111b)](https://github.com/RedFlame2112/dotfiles/commits/main)

</div>

## SYSTEM_LOADOUT

My personal Arch Linux and Hyprland environment. 
I themed this after Silver Wolf from Honkai: Star rail, who is my favorite character!

| Component | Configuration |
| --- | --- |
| Window manager | Hyprland |
| Terminal | Kitty + Powerlevel10k |
| Shell | Zsh + Oh My Zsh |
| Editor | Neovim 0.12, tracked as a submodule |
| Launcher | Rofi |
| Notifications | Dunst |
| Lock screen | Swaylock |
| System bar | Waybar / Wayle |
| Package layer | Arch packages + Home Manager |

## FEATURES

- Deny-by-default Git tracking so caches, credentials, history, cookies, logs,
  and machine state stay out of the repository.
- A modern Neovim environment with native LSP, completion, Treesitter, DAP,
  Conform formatting, Flash navigation, TODO navigation, and Codex workflows.
- Silver Wolf–styled Hyprland, Rofi, Dunst, Kitty, Fastfetch, and Waybar themes.
- Deduplicated shell PATH with conditional initialization for Nix, pyenv, Conda,
  opam, Cargo, and project tooling.
- Home Manager packages and utility scripts, including curated configuration
  backups and repeatable validation.

## INSTALL_SEQUENCE

> [!WARNING]
> Review the repository before checkout. These files target Arch Linux and can
> replace existing configuration in your home directory.

```bash
git clone --bare https://github.com/RedFlame2112/dotfiles.git "$HOME/dotfiles"

git --git-dir="$HOME/dotfiles" \
  --work-tree="$HOME" \
  checkout

git --git-dir="$HOME/dotfiles" \
  --work-tree="$HOME" \
  submodule update --init --recursive

exec zsh
```

If checkout reports conflicting files, back them up first and retry. The
repository intentionally does not automate destructive replacement.

## COMMAND_DECK

The `dots` alias targets the bare repository while leaving `$HOME` as the live
work tree:

```bash
dots status
dots add ~/.zshrc ~/.config/hypr/userprefs.conf
dots commit -m "Tune the system"
dots push
```

Update the Neovim submodule independently, then record its new revision:

```bash
git -C ~/.config/nvim pull
dots add ~/.config/nvim
dots commit -m "Update Neovim submodule"
dots push
```

Run available configuration checks with:

```bash
dotfiles-check
```

## FILE_TREE

```text
~
├── .config/
│   ├── home-manager/   # packages, session variables, utility scripts
│   ├── hypr/           # compositor, bindings, rules, theme
│   ├── nvim/           # independent Git submodule
│   ├── kitty/          # terminal
│   ├── rofi/           # launchers and selectors
│   ├── dunst/          # notifications
│   ├── swaylock/       # lock screen
│   └── waybar/         # status bar modules and styling
├── .zshrc              # interactive shell
├── .p10k.zsh           # prompt theme
└── .gitignore          # explicit tracking boundary
```

## SECURITY_PROTOCOL

Only hand-authored preferences are tracked. Electron application history,
browser storage, authentication databases, caches, generated logs, and machine
identifiers are excluded. Secrets should live in a password manager, system
keyring, or ignored environment file—never directly in these configs.

---

<div align="center">
  <sub>Honkai: Star Rail and Silver Wolf are properties of HoYoverse.</sub>
</div>
