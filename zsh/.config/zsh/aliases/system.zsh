# ============================================================================
# Systemd
# ============================================================================

# systemctl shortcuts
alias sc='sudo systemctl'
alias scu='systemctl --user'

alias sce='sudo systemctl enable'
alias scd='sudo systemctl disable'
alias scs='sudo systemctl start'
alias scr='sudo systemctl restart'
alias sct='sudo systemctl stop'
alias scst='sudo systemctl status'
alias scdr='sudo systemctl daemon-reload'
alias scmask='sudo systemctl mask'
alias scunmask='sudo systemctl unmask'
alias scfailed='systemctl --failed'

# journalctl shortcuts
alias jc='journalctl'
alias jcf='journalctl -f'
alias jcu='journalctl -u'
alias jcb='journalctl -b'
alias jce='journalctl -p err'
alias jcw='journalctl -p warning'

# ============================================================================
# Process Management
# ============================================================================

alias ps='ps auxf'
alias psg='ps aux | grep -v grep | grep'
alias psmem='ps aux --sort=-%mem | head -20'
alias pscpu='ps aux --sort=-%cpu | head -20'
alias top='htop 2>/dev/null || top'
alias jobs='jobs -l'
alias kill='kill -9'

# ============================================================================
# Disk and Memory
# ============================================================================

alias df='df -h'
alias du='du -h'
alias dus='du -sh'
alias duf='du -sh * 2>/dev/null | sort -hr | head -20'
alias free='free -h'
alias mem='free -h'

# ============================================================================
# Network
# ============================================================================

alias ports='ss -tulanp'
alias listen='ss -tlnp'
alias established='ss -tnp | grep ESTABLISHED'
alias myip='curl -s ifconfig.me && echo'
alias ips="ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}'"

# DNS
alias dig='dig +short'
alias nslookup='nslookup'

# ============================================================================
# Logs
# ============================================================================

alias tailf='tail -f'
alias syslog='sudo tail -f /var/log/syslog 2>/dev/null || sudo tail -f /var/log/messages'
alias authlog='sudo tail -f /var/log/auth.log 2>/dev/null || sudo tail -f /var/log/secure'

# ============================================================================
# Package Management - Auto-detect distro
# ============================================================================

alias pac='sudo pacman'
alias pacs='sudo pacman -S'
alias pacss='pacman -Ss'
alias pacr='sudo pacman -Rs'
alias pacu='sudo pacman -Syu'
alias pacq='pacman -Q'
alias pacqi='pacman -Qi'
alias pacql='pacman -Ql'
alias pacqo='pacman -Qo'
alias pacclean='sudo pacman -Sc'
alias pacorphans='pacman -Qdt'
alias pacremoveorphans='sudo pacman -Rns $(pacman -Qdtq)'

# AUR helpers
alias parus='paru -S'
alias paruss='paru -Ss'
alias paruu='paru -Syu'

# ============================================================================
# SSH
# ============================================================================

alias sshconfig='${EDITOR:-vim} ~/.ssh/config'
alias sshkeygen='ssh-keygen -t ed25519'
alias sshcopy='ssh-copy-id'
