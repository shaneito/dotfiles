#
# functions.zsh — shell functions (anything too complex for a plain alias).
#

# --- Directory helpers ---------------------------------------------------------------

# Create a directory and cd into it.
mkcd() {
  mkdir -p "$@" && cd "$_"
}

# Create a subdirectory and move everything in the current directory into it.
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
}

# The opposite of mksubdir(): move everything up one level, then remove the
# now-empty current directory.
flattenUp() {
  emulate -L zsh
  setopt extended_glob null_glob dot_glob

  local cur=${PWD:t}
  local parent=${PWD:h}
  local f rc=0

  for f in *(D) .*(D); do
    [[ $f == . || $f == .. ]] && continue
    if [[ -e "$parent/$f" || -L "$parent/$f" ]]; then
      print -u2 "flattenUp: conflict in parent: $f"
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
}

# --- File & app helpers ---------------------------------------------------------------

# Compress a directory into a .tar.gz.
compress() {
  tar cvzf "$1.tar.gz" "$1"
}

# Open a man page in TextEdit — handy for searching/annotating it visually.
teman() {
  man "$1" | col -b | open -f -a TextEdit.app
}

# Yazi (terminal file manager) that leaves your shell cd'd into wherever
# you exit it from.
y() {
  local tmp cwd
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# Interactively pick an AeroSpace TOML config and symlink it in as active.
switchaero() {
  local dir="$HOME/.dotfiles/aerospace"
  local symlink="$HOME/.config/aerospace/aerospace.toml"

  if [[ ! -d $dir ]]; then
    echo "Directory $dir does not exist."
    return 1
  fi

  local toml_files=("$dir"/*.toml)
  if [[ ${#toml_files[@]} -eq 0 ]]; then
    echo "No TOML files found in $dir."
    return 1
  fi

  echo "Select a TOML file:"
  select file in "${toml_files[@]}"; do
    if [[ -n $file ]]; then
      ln -sf "$file" "$symlink"
      echo "Replaced symlink $symlink with $file"
      break
    else
      echo "Invalid selection. Please try again."
    fi
  done
}

# --- Git commit shortcuts (Emoji-Log convention) ---------------------------------------
# https://github.com/ahmadawais/Emoji-Log
# Each stages everything and commits with an emoji-prefixed message, e.g.:
#   gnew "user login"   ->   git commit -m "📦 NEW: user login"

gcap() {
  git add . && git commit -m "$*"
}

gnew() { gcap "📦 NEW: $@"; }
gimp() { gcap "👌 IMPROVE: $@"; }
gfix() { gcap "🐛 FIX: $@"; }
grlz() { gcap "🚀 RELEASE: $@"; }
gdoc() { gcap "📖 DOC: $@"; }
gtst() { gcap "🤖 TEST: $@"; }
gbrk() { gcap "‼️ BREAKING: $@"; }

# Cheat sheet for the emoji-log commit shortcuts above.
gtype() {
  local NORMAL='\033[0;39m'
  local GREEN='\033[0;32m'
  echo "$GREEN gnew$NORMAL  — 📦 NEW
$GREEN gimp$NORMAL  — 👌 IMPROVE
$GREEN gfix$NORMAL  — 🐛 FIX
$GREEN grlz$NORMAL  — 🚀 RELEASE
$GREEN gdoc$NORMAL  — 📖 DOC
$GREEN gtst$NORMAL  — 🤖 TEST
$GREEN gbrk$NORMAL  — ‼️ BREAKING"
}
