export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND" FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
source /usr/share/fzf/key-bindings.zsh          # ctrl-t insert file, alt-c cd dir
eval "$(atuin init zsh --disable-up-arrow)"     # last so atuin owns ctrl-r; up-arrow stays native
# OSC-133 prompt marks: kitty can jump between prompts and copy last output
autoload -Uz add-zsh-hook
_osc133_pre()  { print -n "\e]133;C\e\\" }
_osc133_post() { print -n "\e]133;D;$?\e\\" }
add-zsh-hook preexec _osc133_pre; add-zsh-hook precmd _osc133_post
# desktop notification when a command ran longer than 30s
_t0=0; _long_pre() { _t0=$SECONDS; }
_long_post() { (( _t0 && SECONDS-_t0 > 30 )) && command -v notify-send >/dev/null && notify-send "done ($((SECONDS-_t0))s)" "$(fc -ln -1)"; _t0=0; }
add-zsh-hook preexec _long_pre; add-zsh-hook precmd _long_post
