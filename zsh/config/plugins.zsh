#
# plugins.zsh — completion system, plugin configuration, and the plugin
# manager (antidote).
#
# A plugin reads its config the moment it loads, so this file is deliberately
# ordered: 1) completion system, 2) config for each plugin, 3) actually load
# the plugins. Don't reorder 2 and 3 or the config below will be ignored.
#

# --- 1. Completion system (compinit) ----------------------------------------------
# `compinit` normally re-scans every completion function and rebuilds its cache
# on EVERY new shell — one of the biggest slowdowns in a typical zsh startup.
# This only does the full rebuild once every 24 hours; otherwise it loads the
# existing cache with `-C` (skips the security check) instead.
autoload -Uz compinit
_zcompdump="${XDG_CACHE_HOME}/zsh/.zcompdump"
mkdir -p "${_zcompdump:h}"
if [[ -n "${_zcompdump}"(#qN.mh+24) ]]; then
  compinit -d "${_zcompdump}"      # cache missing or older than 24h: full check
else
  compinit -C -d "${_zcompdump}"   # cache is fresh: just load it
fi
unset _zcompdump

# --- 2. Plugin configuration -------------------------------------------------------
# These variables/functions are read by the matching plugin as soon as it's
# loaded below, so they MUST be set before step 3.

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# fzf-tab
zstyle ":fzf-tab:*" use-fzf-default-opts yes
zstyle ":fzf-tab:complete:cd:*" fzf-preview "eza -1 --color=always \${realpath}"

# zsh-abbr
ABBR_SET_EXPANSION_CURSOR=1   # enables expansion-cursor placement via '%'

# zsh-vi-mode
ZVM_INIT_MODE=sourcing
function zvm_config() {
  ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
  ZVM_SYSTEM_CLIPBOARD_ENABLED=true
  ZVM_CLIPBOARD_COPY_CMD=pbcopy
  ZVM_CLIPBOARD_PASTE_CMD=pbpaste
  ZVM_VI_HIGHLIGHT_BACKGROUND=green
  ZVM_VI_HIGHLIGHT_FOREGROUND=black
}

# --- 3. Plugin manager (antidote) --------------------------------------------------
# antidote can either resolve + load plugins fresh on every startup
# ("antidote load", slower) or read a pre-built static bundle file
# ("antidote bundle", much faster). This regenerates that bundle only when
# plugins.txt has actually changed since the last shell startup.
source "$(brew --prefix)/opt/antidote/share/antidote/antidote.zsh"

_antidote_plugins="${DOTFILES}/zsh/config/plugins.txt"
_antidote_bundle="${XDG_CACHE_HOME}/zsh/antidote-plugins.zsh"
mkdir -p "${_antidote_bundle:h}"

if [[ ! -e "${_antidote_bundle}" || "${_antidote_plugins}" -nt "${_antidote_bundle}" ]]; then
  antidote bundle <"${_antidote_plugins}" >"${_antidote_bundle}"
fi
source "${_antidote_bundle}"
unset _antidote_plugins _antidote_bundle
