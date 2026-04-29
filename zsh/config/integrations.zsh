#      _____       _                       _   _                           _
#     |_   _|     | |                     | | (_)                         | |
#       | |  _ __ | |_ ___  __ _ _ __ __ _| |_ _  ___  _ __  ___   _______| |__
#       | | | '_ \| __/ _ \/ _` | '__/ _` | __| |/ _ \| '_ \/ __| |_  / __| '_ \
#      _| |_| | | | ||  __/ (_| | | | (_| | |_| | (_) | | | \__ \_ / /\__ \ | | |
#     |_____|_| |_|\__\___|\__, |_|  \__,_|\__|_|\___/|_| |_|___(_)___|___/_| |_|
#                           __/ |
#                          |___/


###########################
#       CLI TOOLS         #
###########################

# Zshell
#==========
eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# Mise
#==========
eval "$(mise activate zsh)"

# Zoxide
#==========
eval "$(zoxide init --cmd cd zsh)"

# FZF
#==========
export FZF_DEFAULT_COMMAND="rg --files --follow --hidden --glob '!.git'"
export FZF_DEFAULT_OPTS="--highlight-line --info=inline-right --ansi --layout=reverse --border=none"
export FZF_CTRL_T_OPTS="--preview='less {}' --height=100%"
eval "$(fzf --zsh)"

# Fasder
#==========
eval "$(fasder --init auto aliases)"

# Starship
#==========
source ~/.local/share/zsh/plugins/starship/starship.zsh
initialize_starship

# completions
# ==========
fpath=(~/.local/share/zsh/completions $fpath)

###########################
#       ZSH PLUGINS       #
###########################



# VI MODE
#==========

bindkey -v

function zvm_config() {
  ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
  ZVM_SYSTEM_CLIPBOARD_ENABLED=true
  ZVM_CLIPBOARD_COPY_CMD=pbcopy
  ZVM_CLIPBOARD_PASTE_CMD=pbpaste
  ZVM_VI_HIGHLIGHT_BACKGROUND=green
  ZVM_VI_HIGHLIGHT_FOREGROUND=black
}

source ~/.local/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# ZSH-AUTOSUGGESTIONS
#==============
source ~/.local/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# FZF-TAB
#==========
autoload -U compinit; compinit
source ~/.local/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

zstyle ":fzf-tab:*" use-fzf-default-opts yes
zstyle ":fzf-tab:complete:cd:*" fzf-preview "eza -1 --color=always \${realpath}"

# FAST-SYNTAX-HIGHLIGHTING
#========================
source ~/.local/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh


# ZSH-ABBR
#========================
source ~/.local/share/zsh/plugins/zsh-abbr/zsh-abbr.zsh
ABBR_SET_EXPANSION_CURSOR=1 # enablesexpansion cursor placement represented by '%'

# BROOT
#========================
source /Users/shane/.config/broot/launcher/bash/br

# OLD SETTINGS

## zsh-completions
# if [ -d /opt/homebrew/share/zsh-completions ]; then
#     fpath=(/opt/homebrew/share/zsh-completions $fpath)
#     autoload -U compinit; compinit
# fi
