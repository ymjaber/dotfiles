fpath+=(/usr/share/zsh/site-functions)
autoload -Uz compinit
mkdir -p "$XDG_CACHE_HOME/zsh"; compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"  # completion cache out of ~
source /usr/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh                    # tab completion menu becomes fzf
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh   # ghost text from history
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  # must stay last, wraps the input line
