#!/bin/bash
set -e
# our two unit files land in the "after" phase, so systemd hasn't seen them yet
systemctl --user daemon-reload
# packaged units — Arch ships them all disabled; each is WantedBy=graphical-session.target
systemctl --user enable waybar.service swaync.service hypridle.service hyprsunset.service \
  cliphist.service hyprpolkitagent.service
# ours (nothing ships these upstream)
systemctl --user enable awww-daemon.service cliphist-image.service
# satty won't create its output dir, and git can't carry an empty one

# pass 2: our own watchers. graphical-session for the one that needs the compositor,
# default.target for the two that must also work in a plain TTY login.
systemctl --user enable monitor-watch.service power-profile-watch.service \
  bt-audio-switch.service battery-notify.timer

mkdir -p ~/Pictures/screenshots
