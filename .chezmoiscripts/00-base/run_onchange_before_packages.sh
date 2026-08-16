#!/bin/bash
set -e
if ! command -v paru &>/dev/null; then
  sudo pacman -S --needed --noconfirm base-devel git rustup
  rustup default stable
  t=$(mktemp -d); trap 'rm -rf "$t"' EXIT
  git clone https://aur.archlinux.org/paru.git "$t/paru"
  (cd "$t/paru" && makepkg -si --noconfirm)
fi

# official repos — no AUR round-trip, so a flaky AUR can't block them
sudo pacman -S --needed --noconfirm \
  age \
  git \
  pacman-contrib \
  zsh \
  zsh-completions \
  zsh-autosuggestions \
  zsh-syntax-highlighting \
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
  vivid \
  neovim \
  pkgfile \
  kitty \
  zellij \
  yazi \
  wl-clipboard \
  ttf-jetbrains-mono-nerd \
  7zip \
  poppler \
  ffmpeg \
  imagemagick \
  python

# from the AUR (unreviewed upstream — keep this list short and deliberate)
paru -S --needed --noconfirm \
  fzf-tab \
  ripdrag
