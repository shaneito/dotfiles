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
