#!/bin/bash
# bash <(curl -fsSL https://raw.githubusercontent.com/ymjaber/dotfiles/main/bootstrap.sh)
set -euo pipefail
sudo pacman -S --needed --noconfirm chezmoi
exec chezmoi init --apply ymjaber/dotfiles
