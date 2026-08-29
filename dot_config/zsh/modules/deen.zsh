# deen.zsh — next prayer on shell start (the CLI decides what to say; empty when no cache)
[[ -o interactive ]] && (( $+commands[prayer] )) && { local _p; _p=$(prayer next 2>/dev/null); [[ -n $_p ]] && print -P "%F{yellow}﷽%f $_p"; }
