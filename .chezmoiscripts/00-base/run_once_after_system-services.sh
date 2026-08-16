#!/bin/bash
set -e
sudo systemctl enable --now pkgfile-update.timer
sudo pkgfile --update
