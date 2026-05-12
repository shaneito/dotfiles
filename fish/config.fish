
# ENVIRONMENT VARIABLES

# DOTFILES AND XDG
# ----------------
set -gx DOTFILES $HOME/.dotfiles
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_STATE_HOME $HOME/.local/state

# PATH
# ----------------
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.local/bin/kanata
fish_add_path $XDG_DATA_HOME/mise/shims
fish_add_path /Applications/Visual Studio Code.app/Contents/Resources/app/bin

# EDITOR
# ----------------
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx VIMCONFIG $XDG_CONFIG_HOME/nvim

# VIM
set fish_key_bindings fish_user_key_bindings

# HOMEBREW
# ----------------
set -gx HOMEBREW_CASK_OPTS "--no-quarantine --no-binaries"
set -gx HOMEBREW_BUNDLE_FILE $DOTFILES/brew/Brewfile

if test -d (brew --prefix)"/share/fish/completions"
  set -p fish_complete_path (brew --prefix)/share/fish/completions
end

if test -d (brew --prefix)"/share/fish/vendor_completions.d"
  set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end

# BAT
# ----------------
set -gx BAT_CONFIG_PATH $XDG_CONFIG_HOME/bat/bat.conf

# STARSHIP
# ----------------
set -gx STARSHIP_CONFIG $DOTFILES/starship/starship.toml
starship init fish | source


# FZF
# ----------------
fzf --fish | source

# FASDER
# ----------------
fasder init auto aliases | source


# ZOXIDE
# ----------------
zoxide init fish | source
