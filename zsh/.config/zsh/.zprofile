# ============================================================================
# Default Applications
# ============================================================================

export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-$EDITOR}"

export PAGER="${PAGER:-less}"
export BROWSER="${BROWSER:-firefox}"

export DOTFILES_DIR="$HOME/.dotfiles"

if [[ -n $TMUX ]]; then
    export TERM=tmux-256color
fi

# ============================================================================
# Less Configuration
# ============================================================================

export LESS="-iRXF"
export LESSHISTFILE="${XDG_STATE_HOME}/less/history"

# ============================================================================
# PATH (login/session)
# ============================================================================

typeset -U path  # Ensure unique entries

path=(
    $HOME/.local/bin
    $DOTNET_CLI_HOME/tools
    $HOME/.git-fuzzy/bin
    $HOME/.scripts
    $HOME/.local/share/JetBrains/Toolbox/apps/rider/bin

    $path
)

export PATH

