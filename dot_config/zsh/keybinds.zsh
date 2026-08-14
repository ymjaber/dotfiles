bindkey -v                              # vi mode
export KEYTIMEOUT=1                     # 10ms esc = instant mode switch
# cursor shape follows the mode: block in normal, beam in insert (same contract as nvim)
function zle-keymap-select {
  case $KEYMAP in vicmd) print -n '\e[2 q';; *) print -n '\e[6 q';; esac
}
function zle-line-init { print -n '\e[6 q' }   # every new prompt starts in insert
zle -N zle-keymap-select; zle -N zle-line-init
bindkey '^?' backward-delete-char       # backspace deletes past the insert point too
# esc esc = prepend sudo to this (or the previous) command
sudo-cmd() { [[ -z $BUFFER ]] && BUFFER="sudo $(fc -ln -1)" || BUFFER="sudo $BUFFER"; CURSOR=$#BUFFER }
zle -N sudo-cmd; bindkey '\e\e' sudo-cmd
bindkey '^ ' autosuggest-accept         # ctrl-space accepts the ghost text
