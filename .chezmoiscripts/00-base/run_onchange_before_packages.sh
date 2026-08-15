#!/bin/bash
set -e
if ! command -v paru &>/dev/null; then
  sudo pacman -S --needed --noconfirm base-devel git rustup
  rustup default stable
  t=$(mktemp -d); trap 'rm -rf "$t"' EXIT
  git clone https://aur.archlinux.org/paru.git "$t/paru"
  (cd "$t/paru" && makepkg -si --noconfirm)
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
  neovim \
  7zip \
  poppler \
  ffmpeg \
  imagemagick
