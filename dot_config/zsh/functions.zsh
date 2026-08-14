mkcd() { mkdir -p "$1" && cd "$1" }
# yazi that cd's to wherever you quit it
y() { local t=$(mktemp); yazi --cwd-file="$t" "$@"; local d=$(cat "$t"); rm -f "$t"; [[ -d $d ]] && cd "$d" }
# fuzzy-pick a file with preview, open in nvim
ff() { local f=$(fzf --preview 'bat --color=always --style=numbers {}'); [[ $f ]] && nvim "$f" }
hash -d cfg=~/.config dl=~/Downloads dots=~/.local/share/chezmoi   # named dirs: cd ~cfg / ~dl / ~dots
# update everything, trim package cache, drop orphans, vacuum old logs
maintenance() { paru -Syu && paccache -rk2 && paru -c && \
  { pacman -Qtdq | sudo pacman -Rns - 2>/dev/null; }; sudo journalctl --vacuum-time=2weeks; }
edir() { [[ -d $1 ]] && tar -cz "$1" | age -p > "$1.tar.gz.age" && rm -rf "$1"; }  # passphrase-encrypt a folder
ddir() { age -d "$1" | tar -xz && rm -f "$1"; }                                    # and decrypt it back
