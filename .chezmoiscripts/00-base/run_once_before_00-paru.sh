#!/bin/bash
# Build the AUR helper from source if absent (once per machine).
command -v paru &>/dev/null && exit 0
sudo pacman -S --needed --noconfirm base-devel rustup
rustup default stable 2>/dev/null || true
t=$(mktemp -d) && git clone https://aur.archlinux.org/paru.git "$t/paru"
(cd "$t/paru" && makepkg -si --noconfirm) && rm -rf "$t"
