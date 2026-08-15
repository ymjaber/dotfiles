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
  pacman-contrib \
  zsh \
  zsh-completions \
  zsh-autosuggestions \
  zsh-syntax-highlighting \
  fzf-tab \
  starship \
  atuin \
  fzf \
  fd \
  ripgrep \
  zoxide \
  eza \
  bat \
  dust \
  duf \
  procs \
  btop \
  bandwhich \
  lazygit \
  git-delta \
  fastfetch \
  tealdeer \
  jq \
  go-yq \
  direnv \
  trash-cli \
  hyperfine \
  kitty \
  zellij \
  yazi \
  ripdrag \
  wl-clipboard \
  ttf-jetbrains-mono-nerd \
  vivid \
  neovim
