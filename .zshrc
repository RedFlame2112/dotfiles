# Keep PATH unique and avoid running language package managers at startup.
typeset -U path PATH
path=(
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "$HOME/go/bin"
  "$HOME/.spicetify"
  "$HOME/spark/bin"
  $path
)
export PATH
export LIBCLANG_PATH=/usr/lib
export SPARK_HOME="$HOME/spark"
export PYENV_ROOT="$HOME/.pyenv"

# Oh My Zsh and Powerlevel10k.
ZSH=/usr/share/oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git sudo zsh-256color zsh-autosuggestions zsh-syntax-highlighting)
source "$ZSH/oh-my-zsh.sh"

# Ask pacman which package provides an unknown executable.
function command_not_found_handler {
  local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
  printf 'zsh: command not found: %s\n' "$1"
  local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
  local entry pkg
  for entry in "${entries[@]}"; do
    local fields=( ${(0)entry} )
    if [[ $pkg != "${fields[2]}" ]]; then
      printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
    fi
    printf '    /%s\n' "${fields[4]}"
    pkg="${fields[2]}"
  done
  return 127
}

if (( $+commands[yay] )); then
  aurhelper=yay
elif (( $+commands[paru] )); then
  aurhelper=paru
fi

function in {
  local -a arch aur
  local pkg
  for pkg in "$@"; do
    if pacman -Si "$pkg" &>/dev/null; then
      arch+=("$pkg")
    else
      aur+=("$pkg")
    fi
  done
  ((${#arch[@]})) && sudo pacman -S "${arch[@]}"
  if ((${#aur[@]})); then
    if [[ -z $aurhelper ]]; then
      print -u2 "No AUR helper found (install yay or paru)."
      return 1
    fi
    "$aurhelper" -S "${aur[@]}"
  fi
}

# Shell conveniences.
alias c='clear'
alias l='eza -lh --icons=auto'
alias ls='eza -1 --icons=auto'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
alias ld='eza -lhD --icons=auto'
alias lt='eza --icons=auto --tree'
alias vc='code'
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias mkdir='mkdir -p'
alias ghidra="$HOME/Tools/ghidra/ghidraRun"
alias wolfmatrix='cmatrix -b -u 3 -C magenta'
alias bluematrix='cmatrix -b -u 3 -C blue'
alias tealmatrix='cmatrix -b -u 3 -C cyan'
alias dots='git --git-dir="$HOME/dotfiles" --work-tree="$HOME"'

if [[ -n $aurhelper ]]; then
  alias un="$aurhelper -Rns"
  alias up="$aurhelper -Syu"
  alias pl="$aurhelper -Qs"
  alias pa="$aurhelper -Ss"
  alias pc="$aurhelper -Sc"
fi

[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

# Show system info only in the first interactive terminal shell.
if [[ $SHLVL -eq 1 && -o interactive && -t 1 ]] && (( $+commands[fastfetch] )); then
  fastfetch
fi

# Optional environment managers.
if [[ -r "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
  source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi
if (( $+commands[pyenv] )); then
  eval "$(pyenv init - zsh)"
fi
[[ -r "$HOME/.opam/opam-init/init.zsh" ]] && source "$HOME/.opam/opam-init/init.zsh" >/dev/null 2>&1

# Conda's generated hook, kept conditional and portable across home paths.
__conda_bin="$HOME/.pyenv/versions/miniforge3-24.3.0-0/bin/conda"
if [[ -x $__conda_bin ]]; then
  __conda_setup="$("$__conda_bin" shell.zsh hook 2>/dev/null)"
  if [[ $? -eq 0 ]]; then
    eval "$__conda_setup"
  elif [[ -r "${__conda_bin:h:h}/etc/profile.d/conda.sh" ]]; then
    source "${__conda_bin:h:h}/etc/profile.d/conda.sh"
  fi
  unset __conda_setup
fi
unset __conda_bin

[[ $TERM == xterm-kitty ]] && alias ssh='kitty +kitten ssh'
