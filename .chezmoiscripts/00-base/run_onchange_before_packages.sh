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
  python \
  hyprland \
  xdg-desktop-portal-hyprland \
  xdg-desktop-portal-gtk \
  hyprpolkitagent \
  qt5-wayland \
  qt6-wayland \
  hyprshutdown \
  greetd \
  greetd-tuigreet \
  rofi \
  swaync \
  cliphist \
  hypridle \
  hyprlock \
  hyprpicker \
  hyprsunset \
  awww \
  grim \
  slurp \
  satty \
  brightnessctl \
  playerctl \
  blueman \
  network-manager-applet \
  thunar \
  thunar-volman \
  gvfs \
  gvfs-mtp \
  tumbler \
  ffmpegthumbnailer \
  nwg-look \
  papirus-icon-theme \
  matugen \
  mesa-utils \
  firefox \
  inter-font \
  noto-fonts \
  noto-fonts-emoji \
  noto-fonts-cjk \
  libqalculate \
  tesseract \
  tesseract-data-eng \
  zbar \
  socat \
  bc \
  libnotify \
  bluez-utils \
  tlp-pd \
  wireplumber \
  sof-firmware \
  libpulse \
  networkmanager \
  fprintd \
  rofi-calc \
  rofi-emoji \
  tesseract-data-ara \
  plasma-meta \
  hyprsunset \
  swayosd \
  github-cli \
  stylua \
  shfmt \
  dotnet-sdk \
  nodejs \
  npm \
  lua-language-server \
  bash-language-server \
  yaml-language-server \
  tree-sitter-cli \
  vscode-json-languageserver \
  marksman \
  shellcheck \
  typescript \
  dart-sass \
  mpv

# from the AUR (unreviewed upstream — keep this list short and deliberate)
paru -S --needed --noconfirm \
  fzf-tab \
  ripdrag \
  grimblast \
  pwvucontrol \
  qt6ct-kde \
  bibata-cursor-theme-bin \
  ttf-amiri \
  hyprshade \
  firefox-tridactyl-native \
  netcoredbg \
  jetbrains-toolbox \
  visual-studio-code-bin \
  libastal-git \
  libastal-4-git \
  libastal-io-git \
  libastal-hyprland-git \
  libastal-battery-git \
  libastal-wireplumber-git \
  libastal-powerprofiles-git \
  libastal-mpris-git \
  libastal-network-git \
  libastal-bluetooth-git \
  libastal-tray-git \
  libastal-cava-git \
  aylurs-gtk-shell \
  python-hijridate \
  quran-companion
