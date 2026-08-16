alias ls='eza --icons --group-directories-first'
alias ll='eza -la --icons --git'
alias lt='eza --tree -L2'
alias cat='bat --paging=never'
alias df='duf' du='dust' top='btop'
alias v='nvim' lg='lazygit'
alias cz='chezmoi' cze='chezmoi edit --apply' czd='chezmoi diff'
alias sy='paru -Syu'
alias rm='trash-put'                    # reversible delete (trash-list/-restore/-empty); \rm forces a real one
alias pacin="paru -Slq | fzf -m --preview 'paru -Si {1}' | xargs -ro paru -S"    # fuzzy package install
alias pacrem="paru -Qq | fzf -m --preview 'paru -Qi {1}' | xargs -ro paru -Rns"  # fuzzy package remove
alias cp='cp -iv' mv='mv -iv'          # mvi = interactive mv; bare mv stays clean for scripts
alias d='dirs -v'                       # numbered dir stack (AUTO_PUSHD) → cd -3
alias reload='exec zsh'                 # re-exec after a config change
alias czs='chezmoi status' cza='chezmoi apply -v'
alias pacwho='pacman -Qo'               # which package owns this file
alias pacfiles='pacman -Ql'             # what did this package install
alias pacwhy='pactree -r'               # what depends on this package
alias paclog='bat /var/log/pacman.log'
