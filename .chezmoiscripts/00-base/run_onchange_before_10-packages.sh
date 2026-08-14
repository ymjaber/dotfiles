#!/bin/bash
# 00-base packages. This list IS the record: adding a line re-runs this installer.
set -e
paru -S --needed --noconfirm \
  age \
  git \
  pacman-contrib
