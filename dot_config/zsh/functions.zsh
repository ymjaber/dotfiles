mkcd() {
  emulate -L zsh
  (( $# == 1 )) || { print -u2 "usage: mkcd <dir>"; return 2 }
  mkdir -p -- "$1" && builtin cd -- "$1"
}

# yazi that cd's to wherever you quit it
y() {
  emulate -L zsh
  local tmp cwd ret
  tmp=$(mktemp) || return
  yazi --cwd-file="$tmp" "$@"; ret=$?
  IFS= read -r cwd < "$tmp"
  command rm -f -- "$tmp"          # temp file, not user data — never the trash
  [[ -n $cwd && -d $cwd && $cwd != $PWD ]] && builtin cd -- "$cwd"
  return $ret
}

# fuzzy-pick files (multi-select), open in nvim; NUL-delimited for odd filenames
ff() {
  emulate -L zsh
  local out; out=$(fd --type f --hidden --exclude .git -0 |
    fzf --read0 --print0 --multi --preview 'bat --color=always --style=numbers {}') || return
  local -a files=("${(@0)out}"); files=(${files:#})
  (( ${#files} )) && nvim -- "${files[@]}"
}

hash -d cfg=~/.config dl=~/Downloads dots=~/.local/share/chezmoi   # cd ~cfg / ~dl / ~dots

# update, clean, drop orphans, vacuum logs — each step guards the next
maintenance() {
  emulate -L zsh
  paru -Syu || return          # cache trimming is the pacman hook's job
  paru -c   || return
  local -a orphans=(${(f)"$(pacman -Qtdq)"})
  (( ${#orphans} )) && { sudo pacman -Rns -- "${orphans[@]}" || return }
  sudo journalctl --vacuum-time=2weeks
}

# encrypt a directory, verified before the original is trashed (one extra passphrase prompt)
edir() {
  emulate -L zsh
  set -o pipefail
  [[ -d $1 ]] || { print -u2 "edir: not a directory: $1"; return 2 }
  local out="${1%/}.tar.gz.age" tmp
  [[ -e $out ]] && { print -u2 "edir: refusing to overwrite $out"; return 1 }
  tmp="$out.part"
  tar -cz -- "$1" | age -p > "$tmp" || { command rm -f -- "$tmp"; return 1 }
  age -d "$tmp" | tar -tz >/dev/null || { print -u2 "edir: verify failed"; command rm -f -- "$tmp"; return 1 }
  command mv -- "$tmp" "$out" && trash-put -- "$1"
}

# decrypt one back; a collision is an error, never a silent overwrite
ddir() {
  emulate -L zsh
  set -o pipefail
  [[ -f $1 ]] || { print -u2 "ddir: no such file: $1"; return 2 }
  age -d -- "$1" | tar -xz --keep-old-files || return 1
  trash-put -- "$1"
}
