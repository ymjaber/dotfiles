alias ls='eza --icons --group-directories-first'
alias ll='eza -la --icons --git'
alias lt='eza --tree -L2'
alias cat='bat --paging=never'
alias df='duf' du='dust' top='btop'
alias v='nvim' lg='lazygit' zj='zellij'
alias cz='chezmoi' cze='chezmoi edit --apply' czd='chezmoi diff'
alias sy='paru -Syu'
alias rm='echo use trash (or \\rm)'     # nag toward trash-cli; \rm bypasses when meant
alias pacin="paru -Slq | fzf -m --preview 'paru -Si {1}' | xargs -ro paru -S"    # fuzzy package install
alias pacrem="paru -Qq | fzf -m --preview 'paru -Qi {1}' | xargs -ro paru -Rns"  # fuzzy package remove
alias cp='cp -iv' mvi='mv -iv'          # mvi = interactive mv; bare mv stays clean for scripts
