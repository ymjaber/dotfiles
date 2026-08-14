#!/bin/bash
set -e
sudo mkdir -p /etc/pacman.d/hooks
sudo tee /etc/pacman.d/hooks/paccache.hook >/dev/null <<'HOOK'
[Trigger]
Operation = Install
Operation = Upgrade
Operation = Remove
Type = Package
Target = *
[Action]
Description = Trim package cache (keep 2)
When = PostTransaction
Exec = /usr/bin/paccache -rk2
HOOK
sudo tee /etc/pacman.d/hooks/pkglist.hook >/dev/null <<'HOOK'
[Trigger]
Operation = Install
Operation = Upgrade
Operation = Remove
Type = Package
Target = *
[Action]
Description = Dump explicit package list
When = PostTransaction
Exec = /bin/sh -c '/usr/bin/pacman -Qqe > /etc/pacman.d/pkglist.txt'
HOOK
