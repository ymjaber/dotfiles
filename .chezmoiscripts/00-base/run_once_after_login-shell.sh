#!/bin/bash
[[ $SHELL == */zsh ]] && exit 0
sudo chsh -s /usr/bin/zsh "$USER"
