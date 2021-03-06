# Create a new directory and enter it
function mkd() {
    mkdir -p "$@" && cd "$@"
}

# Determine size of a file or total size of a directory
function fs() {
    if du -b /dev/null > /dev/null 2>&1; then
        local arg=-sbh
    else
        local arg=-sh
    fi
    if [[ -n "$@" ]]; then
        du $arg -- "$@"
    else
        du $arg .[^.]* *
    fi
}

# Use Git’s colored diff when available
hash git &>/dev/null
if [ $? -eq 0 ]; then
    function diff() {
        git diff --no-index --color-words "$@"
    }
fi

# All the dig info
function digg() {
    dig +nocmd "$1" any +multiline +noall +answer
}

# Escape UTF-8 characters into their 3-byte format
function escape() {
    printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
    echo # newline
}

# Decode \x{ABCD}-style Unicode escape sequences
function unidecode() {
    perl -e "binmode(STDOUT, ':utf8'); print \"$@\""
    echo # newline
}

# Get a character’s Unicode code point
function codepoint() {
    perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))"
    echo # newline
}

# Fetch remote file and cat gzip output
function zcaturl() {
    curl "$@" | zcat
}

# Extract most know archives with one command
function extract() {
    if [ -f $1 ]; then
        case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Convert JSON to YAML
function yq() {
    python -c 'import sys, yaml, json; yaml.safe_dump(json.load(sys.stdin), sys.stdout, default_flow_style=False)'
}

# Find a file inverse recursive
function upsearch() {
    if [ -n $1 ]; then
        slashes=${PWD//[^\/]/}
        directory="$PWD"
        for (( n=${#slashes}; n>0; --n )); do
            test -f "${directory}/${1}" && echo "${directory}/${1}" && return
            directory="${directory}/.."
        done
    fi
}

# Fix file/folder permissions
function fixup() {
    directory="${PWD}"
    if [ -n "$1" ]; then
        directory="$(realpath $1)"
    fi
    echo "Fixing file permissions: $directory"
    find "$directory" -type d -exec chmod 0755 {} \;
    find "$directory" -type f -exec chmod 0644 {} \;
}
