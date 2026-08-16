export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND" FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'

# one look for every fzf surface. never add --popup/--tmux here: it breaks fzf-tab
export FZF_DEFAULT_OPTS='--height=60% --layout=reverse --border=rounded --info=inline
  --preview-window=right:55%:wrap --bind=ctrl-/:toggle-preview,ctrl-u:preview-page-up,ctrl-d:preview-page-down'

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"

# the global fzf opts open a preview pane; these fill it
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers {} 2>/dev/null || eza -1 --icons --color=always {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --level=2 --icons --color=always {}'"
source /usr/share/fzf/key-bindings.zsh
# arch: an unknown command tells you which package provides it

_dotfiles_cnf=/usr/share/doc/pkgfile/command-not-found.zsh
[[ -r $_dotfiles_cnf ]] && source $_dotfiles_cnf
unset _dotfiles_cnf

eval "$(atuin init zsh --disable-up-arrow)"     # last so atuin owns ctrl-r; up-arrow stays native

# kitty's own shell integration emits the OSC-133 marks; ours only duplicated them
_dotfiles_t0=0
_dotfiles_long_pre()  { _dotfiles_t0=$SECONDS }
_dotfiles_long_post() { (( _dotfiles_t0 && SECONDS-_dotfiles_t0 > 30 )) && command -v notify-send >/dev/null &&
  notify-send "done ($((SECONDS-_dotfiles_t0))s)" "$(fc -ln -1)"; _dotfiles_t0=0 }
add-zsh-hook preexec _dotfiles_long_pre; add-zsh-hook precmd _dotfiles_long_post
