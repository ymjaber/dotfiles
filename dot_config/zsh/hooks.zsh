export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND" FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'

# one look for every fzf surface. never add --popup/--tmux here: it breaks fzf-tab
export FZF_DEFAULT_OPTS='--height=60% --layout=reverse --border=rounded --info=inline
  --preview-window=right:55%:wrap --bind=ctrl-/:toggle-preview,ctrl-u:preview-page-up,ctrl-d:preview-page-down'

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
source /usr/share/fzf/key-bindings.zsh          # ctrl-t insert file, alt-c cd dir
eval "$(atuin init zsh --disable-up-arrow)"     # last so atuin owns ctrl-r; up-arrow stays native

# kitty's own shell integration emits the OSC-133 marks; ours only duplicated them
_dotfiles_t0=0
_dotfiles_long_pre()  { _dotfiles_t0=$SECONDS }
_dotfiles_long_post() { (( _dotfiles_t0 && SECONDS-_dotfiles_t0 > 30 )) && command -v notify-send >/dev/null &&
  notify-send "done ($((SECONDS-_dotfiles_t0))s)" "$(fc -ln -1)"; _dotfiles_t0=0 }
add-zsh-hook preexec _dotfiles_long_pre; add-zsh-hook precmd _dotfiles_long_post
