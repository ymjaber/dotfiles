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
  bt-audio-switch.service
# --now for TIMERS only: timers.target activates once per `systemd --user` start and that
# manager outlives logouts, so a plain enable waits for a reboot. Services are fine without
# it — graphical-session.target restarts every login. --now on those would break a TTY apply.
systemctl --user enable --now battery-notify.timer

# theming: the service runs once per session (a night login must not wait for the next tick),
# the timer reconciles every 15 minutes
systemctl --user enable sun.service
systemctl --user enable --now sun.timer

mkdir -p ~/Pictures/screenshots
