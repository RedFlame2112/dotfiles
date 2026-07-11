# Silver Wolf dotfiles

This home directory is managed by a bare Git repository at `~/dotfiles`.
The repository uses `$HOME` as its work tree, so live configuration files are
tracked without symlinks.

## Usage

```sh
dots status
dots add ~/.zshrc ~/.config/hypr/userprefs.conf
dots commit -m "Describe the change"
```

The `dots` alias is defined in `.zshrc`. For a new machine:

```sh
git clone --bare <repository-url> "$HOME/dotfiles"
git --git-dir="$HOME/dotfiles" --work-tree="$HOME" checkout
git --git-dir="$HOME/dotfiles" --work-tree="$HOME" config status.showUntrackedFiles no
```

The ignore policy is deny-by-default. Code history, logs, cookies, databases,
caches and authentication state must never be added. Neovim is linked as a Git
submodule under `~/.config/nvim`.

Run `~/.local/bin/dotfiles-check` after changing configuration.
