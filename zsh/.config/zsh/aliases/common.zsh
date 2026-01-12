# =============================================================================
# Directory Navigation
# =============================================================================

alias cd='z'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias -- -='cd -'

# Quick directory access
alias dl='cd ~/Downloads'
alias proj='cd ~/projects'
alias conf='cd ~/.config'
alias notes='cd ~/notes'
alias docs='cd ~/Documents'
alias scripts='cd ~/.scripts'
alias dots='cd ~/.dotfiles'

# =============================================================================
# File Listing
# =============================================================================

alias ls='eza --icons=never --color=always --group-directories-first'

alias l='eza --icons=always --color=always --group-directories-first'
alias la='l -a'

alias ll='l -l --git'
alias lla='l -la --git'

alias lt='l -T'
alias lta='l -aT'
alias llt='l -lT'
alias llta='l -laT'

alias ltl='l -TL'
alias ltla='l -aTL'
alias lltl='l -lTL'
alias lltla='l -laTL'

# =============================================================================
# File Operations
# =============================================================================

# Safety - confirm before overwriting
alias cp='cp -iv'
alias mv='mv -iv'

# Create parent directories as needed
alias mkdir='mkdir -pv'

# =============================================================================
# Text and Files
# =============================================================================

alias cat='bat'
alias catp='bat --plain'

# =============================================================================
# Apps
# =============================================================================

alias v='nvim'
alias t='tmux'

# =============================================================================
# System
# =============================================================================

alias reload='exec ${SHELL}'
alias path='echo $PATH | tr ":" "\n"'
alias week='date +%V'
alias hibernate='systemctl hibernate'

# =============================================================================
# Misc
# =============================================================================

alias h='history'
alias c='clear'
alias q='exit'

# Copy/paste
alias copy='wl-copy'
alias paste='wl-paste'

alias pc='pwd | copy'

# =============================================================================
# Global Aliases
# =============================================================================

alias -g G='| rg'
alias -g L='| less'
alias -g H='| head'
alias -g HN='| head -n'
alias -g T='| tail'
alias -g TN='| tail -n'
alias -g NUL='> /dev/null 2>&1'
alias -g JSON='| jq .'
alias -g LINES='| wc -l'
alias -g WORDS='| wc -w'

# =============================================================================
# fzf
# =============================================================================

alias f='fzf'
alias ff='fd --type f --hidden --follow | fzf' # Files only
alias fdir='fd --type d --hidden --follow | fzf' # Directories only

alias fcd='cd $(fdir)' # FZF & navigate to directory
alias fcl='cl $(fdir)' # FZF, navigate to directory & list its content

alias fv='nvim $(ff)' # FZF & open file with NeoVim
alias fvcd='vcd $(fdir)' # FZF & open directory with NeoVim
