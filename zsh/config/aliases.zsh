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
alias ga="git add --all"
alias gb="git branch"
alias gc="git commit -m"
alias gl="git log --oneline"
alias gs="git status"
alias gw="git switch"

# --- Editing configs -------------------------------------------------------------------
alias edz="$EDITOR $DOTFILES/zsh"
alias edt="$EDITOR $DOTFILES/tmux/tmux.conf"
alias edv="$EDITOR $DOTFILES/nvim"
alias reload="source $XDG_CONFIG_HOME/zsh/.zshrc"

# --- Bat (a `cat` with syntax highlighting) ---------------------------------------------
alias cat='bat'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
alias fz='fzf --preview "bat --style=header --color=always --line-range :50 {}" --preview-window=right:60% | xargs open'

# --- Neovim variants (separate config profiles via NVIM_APPNAME) -----------------------
alias vi="nvim"
alias vim="nvim"
alias vsvim="NVIM_APPNAME=nvim-vscode nvim"

# --- Programming
alias python=python3

# --- Misc ------------------------------------------------------------------------------
alias c="clear"
alias clera="clear"
alias man="batman"
alias grep="grep --color=auto"
