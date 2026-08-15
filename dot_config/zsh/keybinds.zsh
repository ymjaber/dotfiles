bindkey -v                              # vi mode
export KEYTIMEOUT=5                     # 50ms; at 10ms the esc-esc sudo bind was unreachable
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

# edit the current command in nvim; write+quit runs it. never bind `v` — that's visual mode
autoload -Uz edit-command-line; zle -N edit-command-line
bindkey -M vicmd '!' edit-command-line
bindkey -M viins '^X^E' edit-command-line

# vim text objects on the command line: ci" ca( di[ vi{
autoload -Uz select-bracketed select-quoted
zle -N select-bracketed; zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do bindkey -M $m $c select-bracketed; done
  for c in {a,i}{\',\",\`}; do bindkey -M $m $c select-quoted; done
done

# surround: cs"' change, ds" delete, ys<motion>" add, S in visual
autoload -Uz surround
zle -N delete-surround surround; zle -N add-surround surround; zle -N change-surround surround
bindkey -a cs change-surround; bindkey -a ds delete-surround; bindkey -a ys add-surround
bindkey -M visual S add-surround

# without this, autosuggestions drops you into insert mode after cs/ds
ZSH_AUTOSUGGEST_IGNORE_WIDGETS+=(add-surround change-surround delete-surround select-bracketed select-quoted)
