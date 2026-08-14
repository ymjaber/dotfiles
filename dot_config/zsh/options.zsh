setopt SHARE_HISTORY          # all open shells share one live history
setopt HIST_IGNORE_ALL_DUPS   # a re-run command keeps a single entry
setopt HIST_IGNORE_SPACE      # leading space = kept out of history
setopt AUTO_CD                # a bare directory name cd's into it
setopt INTERACTIVE_COMMENTS   # allow # comments at the prompt
HISTSIZE=100000 SAVEHIST=100000
mkdir -p "$XDG_STATE_HOME/zsh"; HISTFILE="$XDG_STATE_HOME/zsh/history"  # history is state, not config
