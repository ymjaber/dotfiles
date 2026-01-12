# Clear terminal including scrollback (Force kitty terminal to clear scrollback)
clear() {
    # If options/args are passed, behave exactly like the real `clear`
    if (( $# )); then
        command clear "$@"
        return
    fi

    # Normal "clear" behavior + also clear scrollback
    command clear
    printf '\033[3J\033[1;1H'
}

# Navigate into directory and list contents
cl() {
    cd $1 && l
}

# Create directory and cd into it
mkcd() {
    mkdir -p $1 && cd $1
}

# Open a directory in neovim and throw error if it is not a directory
vcd() {
    if [[ -d $1 ]]; then
        cd $1
        nvim .
    else
        echo "Error: '$1' is not a directory" >&2
        return 1
    fi

}

# Create temporary directory and cd into it
tmpcd() {
    cd $(mktemp -d)
}

# Create file with parent directories
touchp() {
    local dir=$(dirname $1)
    [[ -d $dir ]] || mkdir -p $dir
    touch $1
}

# Backup file with timestamp
backup() {
    local file=$1
    local backup=${file}.$(date +%Y%m%d_%H%M%S).bak
    cp -a $file $backup && echo "Backed up to: $backup"
}

# Extract any archive
extract() {
    if [[ ! -f $1 ]]; then
        echo "Error: '$1' is not a file" >&2
        return 1
    fi

    case "$1" in
        *.tar.bz2)   tar xjf $1    ;;
        *.tar.gz)    tar xzf $1    ;;
        *.tar.xz)    tar xJf $1    ;;
        *.tar.zst)   tar --zstd -xf $1 ;;
        *.bz2)       bunzip2 $1    ;;
        *.gz)        gunzip $1     ;;
        *.tar)       tar xf $1     ;;
        *.tbz2)      tar xjf $1    ;;
        *.tgz)       tar xzf $1    ;;
        *.zip)       unzip $1      ;;
        *.Z)         uncompress $1 ;;
        *.7z)        7z x $1       ;;
        *.rar)       unrar x $1    ;;
        *.xz)        xz -d $1      ;;
        *.zst)       zstd -d $1    ;;
        *)           echo "Error: Unknown archive format '$1'" >&2; return 1 ;;
    esac
}

# Find and list large files
findlarge() {
    local size=${1:-100M}
    local dir=${2:-.}
    find $dir -type f -size +$size -exec l -lh {} \; 2>/dev/null | sort -k5 -hr
}
