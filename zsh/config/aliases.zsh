#               _ _                               _
#         /\   | (_)                             | |
#        /  \  | |_  __ _ ___  ___  ___   _______| |__
#       / /\ \ | | |/ _` / __|/ _ \/ __| |_  / __| '_ \
#      / ____ \| | | (_| \__ \  __/\__ \_ / /\__ \ | | |
#     /_/    \_\_|_|\__,_|___/\___||___(_)___|___/_| |_|
#



# Listing
alias ll='eza -laF --git --ignore-glob=".CFUserTextEncoding|.DS_Store"'
alias ls='eza -a --grid --ignore-glob=".CFUserTextEncoding|.DS_Store"'
alias lt='eza --tree'
alias icloud="$HOME/Library/Mobile\ Documents/com~apple~CloudDocs"
alias trail="<<<${(F)path}"
alias ftrail="<<<${(F)fpath}"

# Git
alias ga="git add"
alias gaa="git add -A"
alias gb="git branch"
alias gc="git commit -m"
alias gl="git log --oneline"
alias gs="git status"
alias gw="git switch"

# Homebrew
alias brc="brew install --cask"
alias bbd="brew bundle dump --force"
alias bbi="brew bundle"
alias bru="brew upgrade"
alias brs="brew search"
alias bri="brew info"

# Editing Configs
alias ea="$EDITOR $DOTFILES/zsh/config/aliases.zsh"
alias ee="$EDITOR $HOME/.zshenv"
alias ez="$EDITOR $DOTFILES/zsh"
alias et="$EDITOR $DOTFILES/tmux/tmux.conf"
alias eh="$EDITOR $XDG_CONFIG_HOME/hammerspoon/init.lua"
alias sz="source $XDG_CONFIG_HOME/zsh/.zshrc"

# Bat
alias cat='bat'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
alias fz='fzf --preview "bat --style=header --color=always --line-range :50 {}" --preview-window=right:60% | xargs open'

# Misc
alias vi="nvim"
alias vim="nvim"
alias c="clear"
alias man="batman"
alias grep="grep --color=auto"


alias astro="NVIM_APPNAME=nvim-astro nvim"
