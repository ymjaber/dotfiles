# LS_COLORS must exist before the list-colors zstyle: zstyle captures the value right now
[[ -r ~/.cache/ls-colors ]] || vivid generate catppuccin-mocha >~/.cache/ls-colors 2>/dev/null
[[ -r ~/.cache/ls-colors ]] && export LS_COLORS="$(<~/.cache/ls-colors)"

zmodload zsh/complist                          # list-colors needs it; before compinit
fpath+=("$XDG_DATA_HOME/zsh/site-functions")   # user-generated completions
autoload -Uz compinit
mkdir -p "$XDG_CACHE_HOME/zsh"; compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

zstyle ':completion:*' menu no                 # required by fzf-tab; `menu select` breaks it
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:warnings'     format '%F{red}-- no matches --%f'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' special-dirs true       # complete ./ and ../
zstyle ':completion:*' completer _complete _match _approximate   # typo tolerance

zstyle ':fzf-tab:*' fzf-flags --bind=tab:accept
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons --color=always $realpath'
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview 'git log --color=always $word'
zstyle ':fzf-tab:complete:*:*' fzf-preview 'bat --color=always ${(Q)realpath} 2>/dev/null || eza -1 --icons --color=always ${(Q)realpath}'

# order law: compinit -> fzf-tab -> autosuggestions -> atuin (hooks.zsh) -> highlighting (.zshrc tail)
source /usr/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
