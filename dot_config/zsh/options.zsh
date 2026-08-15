setopt SHARE_HISTORY          # all open shells share one live history
setopt HIST_IGNORE_ALL_DUPS   # a re-run command keeps a single entry
setopt HIST_IGNORE_SPACE      # leading space = kept out of history
setopt AUTO_CD                # a bare directory name cd's into it
setopt INTERACTIVE_COMMENTS   # allow # comments at the prompt
setopt EXTENDED_HISTORY       # timestamp + duration per entry
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY            # !! lands on the line for review instead of firing blind
setopt AUTO_PUSHD             # every cd pushes the stack — `d` lists it, `cd -3` jumps
setopt PUSHD_IGNORE_DUPS PUSHD_SILENT
setopt GLOB_DOTS              # globs match dotfiles
setopt EXTENDED_GLOB
setopt NO_BEEP
WORDCHARS='*?_-.[]~&;!#$%^(){}<>'   # `/` dropped: ctrl-w deletes one path segment
HISTSIZE=100000 SAVEHIST=100000
mkdir -p "$XDG_STATE_HOME/zsh"; HISTFILE="$XDG_STATE_HOME/zsh/history"  # history is state, not config
