#!/usr/bin/env bash
set -euo pipefail

PROFILE="${1:-default}"
TITLE="quake-terminal-${PROFILE}"
CUR_WS="$(hyprctl activeworkspace -j | jq -r '.id')"

# Find the quake window (first match)
client="$(hyprctl clients -j | jq -r --arg t "$TITLE" 'map(select(.title == $t)) | .[0] // empty')"

# If no terminal exists, start one on current workspace (and pinned)
if [[ -z "${client}" ]]; then
  hyprctl dispatch exec "[workspace ${CUR_WS}; pin] kitty --title='${TITLE}'"
  exit 0
fi

PID="$(jq -r '.pid' <<<"$client")"
WS_NAME="$(jq -r '.workspace.name' <<<"$client")"
WS_ID="$(jq -r '.workspace.id' <<<"$client")"
PINNED="$(jq -r '.pinned' <<<"$client")"
ADDR="$(jq -r '.address' <<<"$client")"

# If it's currently hidden in the special workspace -> show it (and pin it)
if [[ "$WS_NAME" == "special:quake" ]]; then
  if [[ "$PINNED" != "true" ]]; then
    hyprctl --batch \
      "dispatch movetoworkspace ${CUR_WS},pid:${PID}; dispatch pin pid:${PID}"
  else
    hyprctl dispatch movetoworkspace "${CUR_WS},pid:${PID}"
  fi
  exit 0
fi

# --- MODIFICATION (your requested 2.1) ---
# If it's on the current workspace but NOT focused -> just focus it.
ACTIVE_ADDR="$(hyprctl activewindow -j | jq -r '.address')"
if [[ "$WS_ID" == "$CUR_WS" && "$ACTIVE_ADDR" != "$ADDR" ]]; then
  hyprctl dispatch focuswindow "address:${ADDR}"
  exit 0
fi
# ----------------------------------------

# Otherwise it's "shown" (and already focused on this workspace) -> hide it
# (unpin first so it actually disappears everywhere)
if [[ "$PINNED" == "true" ]]; then
  hyprctl --batch \
    "dispatch pin pid:${PID}; dispatch movetoworkspacesilent special:quake,pid:${PID}"
else
  hyprctl dispatch movetoworkspacesilent "special:quake,pid:${PID}"
fi
