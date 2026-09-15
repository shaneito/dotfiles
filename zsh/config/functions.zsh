#      ______                _   _                           _     
#     |  ____|              | | (_)                         | |    
#     | |__ _   _ _ __   ___| |_ _  ___  _ __  ___   _______| |__  
#     |  __| | | | '_ \ / __| __| |/ _ \| '_ \/ __| |_  / __| '_ \ 
#     | |  | |_| | | | | (__| |_| | (_) | | | \__ \_ / /\__ \ | | |
#     |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___(_)___|___/_| |_|
#                                                                  
#                                                                  


# Create and cd into created directory
function mkcd() {
  mkdir -p "$@" && cd "$_";
}

# Create a subdirectory and move contents to it
mksubdir() {
    emulate -L zsh
    setopt extended_glob null_glob dot_glob

    local dir=${1:-Project}
    mkdir -p -- "$dir" || return 1

    local f
    for f in *(D) .*(D); do
        [[ $f == . || $f == .. || $f == $dir ]] && continue
        mv -- "$f" "$dir"/ 2>/dev/null || return 1
    done

    return 0
}

flattenUp() {
    emulate -L zsh
    setopt extended_glob null_glob dot_glob

    local cur=${PWD:t}
    local parent=${PWD:h}
    local f rc=0

    for f in *(D) .*(D); do
        [[ $f == . || $f == .. ]] && continue
        if [[ -e "$parent/$f" || -L "$parent/$f" ]]; then
            print -u2 "flatten_up: conflict in parent: $f"
            return 1
        fi
    done

    for f in *(D) .*(D); do
        [[ $f == . || $f == .. ]] && continue
        mv -- "$f" "$parent/" || rc=$?
        (( rc != 0 )) && return $rc
    done

    cd -- "$parent" || return 1
    rmdir -- "$cur" || return 1

    return 0
}


# Compress a directory
function compress() {
    tar cvzf $1.tar.gz $1
}

function teman() {
  man $1 | col -b | open -f -a TextEdit.app
}

function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}


function switchaero() {
  local dir="$HOME/.dotfiles/aerospace"  # Directory containing TOML files
  local symlink="$HOME/.config/aerospace/aerospace.toml"  # Path to the symlink to replace

  # Check if the specified directory exists
  if [[ ! -d $dir ]]; then
    echo "Directory $dir does not exist."
    return 1
  fi

  # List TOML files and allow user to select one
  local toml_files=("$dir"/*.toml)
  if [[ ${#toml_files[@]} -eq 0 ]]; then
    echo "No TOML files found in $dir."
    return 1
  fi

  echo "Select a TOML file:"
  select file in "${toml_files[@]}"; do
    if [[ -n $file ]]; then
      # Replace the symlink with the selected file
      ln -sf "$file" "$symlink"
      echo "Replaced symlink $symlink with $file"
      break
    else
      echo "Invalid selection. Please try again."
    fi
  done
}


#.# Better Git Logs.
### Using EMOJI-LOG (https://github.com/ahmadawais/Emoji-Log).

# Git Commit, Add all and Push — in one step.
gcap() {
    git add . && git commit -m "$*"
}

# NEW.
gnew() {
    gcap "📦 NEW: $@"
}

# IMPROVE.
gimp() {
    gcap "👌 IMPROVE: $@"
}

# FIX.
gfix() {
    gcap "🐛 FIX: $@"
}

# RELEASE.
grlz() {
    gcap "🚀 RELEASE: $@"
}

# DOC.
gdoc() {
    gcap "📖 DOC: $@"
}

# TEST.
gtst() {
    gcap "🤖 TEST: $@"
}

# BREAKING CHANGE.
gbrk() {
    gcap "‼️ BREAKING: $@"
}
gtype() {
NORMAL='\033[0;39m'
GREEN='\033[0;32m'
echo "$GREEN gnew$NORMAL — 📦 NEW
$GREEN gimp$NORMAL — 👌 IMPROVE
$GREEN gfix$NORMAL — 🐛 FIX
$GREEN grlz$NORMAL — 🚀 RELEASE
$GREEN gdoc$NORMAL — 📖 DOC
$GREEN gtst$NORMAL — 🧪️ TEST
$GREEN gbrk$NORMAL — ‼️ BREAKING"
}
