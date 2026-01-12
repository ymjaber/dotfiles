# =============================================================================
# Fastfetch welcome (per terminal window)
# =============================================================================

fastfetch -c ~/.config/fastfetch/config-minimal.jsonc

# =============================================================================
# Instant Prompt (powerlevel10k)
# =============================================================================

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r ${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh ]]; then
  source ${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh
fi

# =============================================================================
# History
# =============================================================================

HISTFILE=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history
[[ -d ${HISTFILE:h} ]] || mkdir -p ${HISTFILE:h}
SAVEHIST=100000
HISTSIZE=100000

setopt EXTENDED_HISTORY       # Record timestamp
setopt HIST_EXPIRE_DUPS_FIRST # Expire dups first
setopt HIST_IGNORE_ALL_DUPS   # Remove all duplicates
setopt HIST_IGNORE_SPACE      # Ignore space-prefixed
setopt HIST_FIND_NO_DUPS      # No dups in search
setopt HIST_REDUCE_BLANKS     # Remove extra blanks
setopt HIST_VERIFY            # Verify before executing
setopt INC_APPEND_HISTORY     # Add immediately
setopt SHARE_HISTORY          # Share between sessions

# =============================================================================
# Options
# =============================================================================

setopt AUTO_CD                # cd by typing directory name
setopt AUTO_PUSHD             # Push to directory stack
setopt PUSHD_IGNORE_DUPS      # No duplicate entries
setopt PUSHD_SILENT           # Don't print stack
setopt CORRECT                # Command correction
setopt EXTENDED_GLOB          # Extended globbing
setopt NO_BEEP                # No beep on error
setopt INTERACTIVE_COMMENTS   # Allow comments in commands
setopt MULTIOS                # Multiple redirections
setopt NO_FLOW_CONTROL        # Disable Ctrl+S/Ctrl+Q

# ============================================================================
# Completion System
# ============================================================================

# Initialize completion with caching
autoload -Uz compinit

() {
    local dump=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump
    local cache=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache

    mkdir -p -- ${dump:h} $cache

    # Full compinit if dump is missing or older than 24h; fast path otherwise
    if [[ ! -e $dump || -n ${dump}(#qN.mh+24) ]]; then
        compinit -d $dump
    else
        compinit -C -d $dump
    fi
}

# Completion styling
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches --%f'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"
zstyle ':completion:*' squeeze-slashes true

# Kill command completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# =============================================================================
# Key Bindings
# =============================================================================

bindkey -v  # Vi key bindings

# Better history search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^P' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search

# Prefer terminfo when available
zmodload -i zsh/terminfo 2>/dev/null


# Home/End keys
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line

# Delete key
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char

# Edit command in editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^E' edit-command-line

# Switch to command/normal mode
bindkey 'jk' vi-cmd-mode

# ============================================================================
# Load Modular Configuration
# ============================================================================

# Source all .zsh files from ZDOTDIR subdirectories
for module in aliases functions plugins themes; do
    if [[ -d ${ZDOTDIR}/$module ]]; then
        for file in ${ZDOTDIR}/$module/*.zsh(N); do
            source $file
        done
    fi
done

# =============================================================================
# Plugins and Themes
# =============================================================================

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# =============================================================================
# Tools Initialization
# =============================================================================

# -----------------------------------------------------------------------------
# FZF
# -----------------------------------------------------------------------------

# Keybindings + completion
[[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
[[ -f /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh

# Preview command
_fzf_preview='
if [ -d {} ]; then
  command eza --color=always --icons --group-directories-first -la {}
else
    command bat --style=numbers,changes --color=always --line-range :400 {}
fi
'

# Toggle preview binding
export FZF_TOGGLE_PREVIEW_BIND='alt-p:toggle-preview'

if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git -t f -t d'
else
    export FZF_DEFAULT_COMMAND='find . -mindepth 1 \( -type f -o -type d \) -not -path "*/.git/*" 2>/dev/null'
fi

# FZF default options
FZF_CATPPUCCIN_MOCHA='
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
  --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
  --color=selected-bg:#45475a,border:#585b70,separator:#585b70,scrollbar:#585b70
'

export FZF_DEFAULT_OPTS="
  --height 80%
  --layout=reverse
  --border
  --ansi
  --preview '$_fzf_preview'
  --preview-window='right,60%,border-left,wrap'
  --bind '$FZF_TOGGLE_PREVIEW_BIND'
  $FZF_CATPPUCCIN_MOCHA
"

# FZF file open options
export FZF_CTRL_T_OPTS="
  --preview '$_fzf_preview'
  --preview-window='right,60%,border-left,wrap'
  --bind '$FZF_TOGGLE_PREVIEW_BIND'
  $FZF_CATPPUCCIN_MOCHA
"

# FZF directory change options
export FZF_ALT_C_OPTS="
  --preview '$_fzf_preview'
  --preview-window='right,60%,border-left,wrap'
  --bind '$FZF_TOGGLE_PREVIEW_BIND'
    $FZF_CATPPUCCIN_MOCHA
"

# -----------------------------------------------------------------------------
# Zoxide
# -----------------------------------------------------------------------------

eval "$(zoxide init zsh)"

# ============================================================================
# Local Configuration
# ============================================================================

# Machine-specific configuration
[[ -f ${ZDOTDIR}/local.zsh ]] && source ${ZDOTDIR}/local.zsh
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Secrets
[[ -f ~/.secrets ]] && source ~/.secrets

# =============================================================================
# Powerlevel10k Theme
# =============================================================================

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ${ZDOTDIR}/.p10k.zsh ]] || source ${ZDOTDIR}/.p10k.zsh

