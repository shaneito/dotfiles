#
# aliases.zsh — shortcuts for commands you type often.
#

# --- Listing (eza) -----------------------------------------------------------------
alias ll='eza -laF --git --ignore-glob=".CFUserTextEncoding|.DS_Store"'
alias ls='eza -a --grid --ignore-glob=".CFUserTextEncoding|.DS_Store"'
alias lt='eza --tree'
alias icloud="$HOME/Library/Mobile\ Documents/com~apple~CloudDocs"
alias trail="<<<${(F)path}"      # print $PATH, one entry per line
alias ftrail="<<<${(F)fpath}"    # print $fpath, one entry per line

# --- Git -----------------------------------------------------------------------------
alias ga="git add"
alias gaa="git add -A"
alias gb="git branch"
alias gc="git commit -m"
alias gl="git log --oneline"
alias gs="git status"
alias gw="git switch"

# --- Homebrew --------------------------------------------------------------------------
alias brc="brew install --cask"
alias bbd="brew bundle dump --force --no-vscode"
alias bbi="brew bundle"
alias bru="brew upgrade"
alias brs="brew search"
alias bri="brew info"

# --- Editing configs -------------------------------------------------------------------
alias ea="$EDITOR $DOTFILES/zsh/config/aliases.zsh"
alias ee="$EDITOR $HOME/.zshenv"
alias ez="$EDITOR $DOTFILES/zsh"
alias et="$EDITOR $DOTFILES/tmux/tmux.conf"
alias eh="$EDITOR $XDG_CONFIG_HOME/hammerspoon/init.lua"
alias sz="source $XDG_CONFIG_HOME/zsh/.zshrc"

# --- Bat (a `cat` with syntax highlighting) ---------------------------------------------
alias cat='bat'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
alias fz='fzf --preview "bat --style=header --color=always --line-range :50 {}" --preview-window=right:60% | xargs open'

# --- Neovim variants (separate config profiles via NVIM_APPNAME) -----------------------
alias vi="nvim"
alias vim="nvim"
alias via="NVIM_APPNAME=nvim-astro nvim"
alias viv="NVIM_APPNAME=nvim-vscode nvim"
alias vil="NVIM_APPNAME=nvim-lazy nvim"
alias vic="NVIM_APPNAME=nvim-nvchad nvim"

# --- Misc ------------------------------------------------------------------------------
alias c="clear"
alias man="batman"
alias grep="grep --color=auto"
