#!/bin/bash
set -euo pipefail
sudo pacman -S --needed --noconfirm chezmoi
exec chezmoi init --apply ymjaber/dotfiles
