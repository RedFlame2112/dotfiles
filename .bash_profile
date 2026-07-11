#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -e /home/quaternion2112/.nix-profile/etc/profile.d/nix.sh ]; then . /home/quaternion2112/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
. "$HOME/.cargo/env"
