#
# tools.zsh — shell integrations for standalone CLI tools.
#
# Each `eval "$(some-tool init zsh)"` runs that tool once at shell startup to
# generate the functions/completions/prompt code it needs for this session.
# This is different from plugins.zsh: nothing here is a zsh *plugin* — these
# are hooks for tools that also work outside zsh.


# --- mise (runtime version manager: node, python, etc.) ---------------------------
# eval "$(mise activate zsh)"

# --- fzf (fuzzy finder) -----------------------------------------------------------
export FZF_DEFAULT_COMMAND="rg --files --follow --hidden --glob '!.git'"
export FZF_DEFAULT_OPTS="--highlight-line --info=inline-right --ansi --layout=reverse --border=none"
export FZF_CTRL_T_OPTS="--preview='less {}' --height=100%"
eval "$(fzf --zsh)"

# --- Zoxide (frecency-based file/directory jumping) -------------------------------
export _ZO_DATA_DIR="$XDG_DATA_HOME/zoxide"
export _ZO_FZF_OPTS="--height 60% --layout=reverse --border --preview='eza -lah --color=always {}' --preview-window=right,60%"
eval "$(zoxide init --cmd j zsh)"

# --- Starship (prompt) ------------------------------------------------------------
export STARSHIP_CONFIG="$DOTFILES/starship/starship.toml"
eval "$(starship init zsh)"

# --- Broot (interactive tree navigator) -------------------------------------------
[ -f "$HOME/.config/broot/launcher/bash/br" ] && source "$HOME/.config/broot/launcher/bash/br"
