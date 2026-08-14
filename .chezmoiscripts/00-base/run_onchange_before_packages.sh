#!/bin/bash
set -e
if ! command -v paru &>/dev/null; then
  sudo pacman -S --needed --noconfirm base-devel rustup
  rustup default stable 2>/dev/null || true
  t=$(mktemp -d) && git clone https://aur.archlinux.org/paru.git "$t/paru"
  (cd "$t/paru" && makepkg -si --noconfirm) && rm -rf "$t"
fi
paru -S --needed --noconfirm \
  age \
  git \
  pacman-contrib
