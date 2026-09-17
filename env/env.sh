#########################################
# General Environment Variables
#########################################


# editor
export EDITOR="nvim"
export VISUAL="nvim"
export DIFFPROG="nvim -d"
export VIMCONFIG="$XDG_CONFIG_HOME/nvim"

# Homebrew
export HOMEBREW_CASK_OPTS="--no-quarantine --no-binaries"
export HOMEBREW_BUNDLE_FILE="$DOTFILES/brew/Brewfile"
export HOMEBREW_NO_ENV_HINTS=1

# App Settings



#########################################
# Languages
#########################################
# Ordered roughly by how much you actually use each one, so the ones you
# touch daily are easiest to find (and win $PATH priority — see the bottom
# of this file).

# Polyglot package root — reuses $XDG_DATA_HOME (~/.local/share) rather than
# inventing a separate ~/.local/pkg tree, since that's already the standard
# "where apps/tools keep their data" spot (it's also where mise itself
# keeps everything, under ~/.local/share/mise). Each language below gets
# its own subfolder under it, e.g. ~/.local/share/cargo.
PKG="$XDG_DATA_HOME"

# ── Node.js / npm — primary daily language ──────────────────
export NPM_CONFIG_PREFIX="$PKG/node"           # where `npm install -g` puts things
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
# NODE_PATH intentionally NOT set: it's a legacy escape hatch for module
# resolution outside a project's own node_modules, and modern Node/npm
# (and tools like webpack/vite/jest) don't expect it — leaving it set can
# cause confusing "wrong version of a package loaded" bugs. If you ever
# hit a specific need for it, better to fix it per-project than globally.

# ── Perl / CPAN — occasional use ─────────────────────────────
export PERL_LOCAL_LIB_ROOT="$PKG/perl"
export PERL_MB_OPT="--install_base $PKG/perl"
export PERL_MM_OPT="INSTALL_BASE=$PKG/perl"
export PERL5LIB="$PKG/perl/lib/perl5"
export CPANM_HOME="$HOME/.cache/cpanm"
export CPM_HOME="$HOME/.cache/cpm"

# ── Python / pip — occasional use ────────────────────────────
export PYTHONUSERBASE="$PKG/python" # Use: pip install --user (respects PYTHONUSERBASE automatically)

# ── C — occasional use ────────────────────────────────────────
# No env vars needed yet — Xcode Command Line Tools / Homebrew's toolchain
# work out of the box. If you start linking against Homebrew-installed
# libraries, this is where a CPATH/LIBRARY_PATH or PKG_CONFIG_PATH would go.

# ── Lua / LuaRocks — tooling language (Neovim plugin dev, not an app language) ──
export LUA_PATH="$PKG/lua/share/lua/5.4/?.lua;;"
export LUA_CPATH="$PKG/lua/lib/lua/5.4/?.so;;"

# ── Rust / Cargo — curiosity ──────────────────────────────────
export CARGO_HOME="$PKG/cargo"
export RUSTUP_HOME="$PKG/rustup"

# ── Go — curiosity ────────────────────────────────────────────
export GOPATH="$PKG/go"

# PATH additions — guard against duplicate entries.
# Called least-used-first, most-used-last: each _prepend_path call wins
# priority over the ones before it, so Node ends up searched first.
_prepend_path() {
    case ":$PATH:" in
        *":$1:"*) ;;          # already present, skip
        *) PATH="$1:$PATH" ;;
    esac
}

_prepend_path "$PKG/go/bin"
_prepend_path "$PKG/cargo/bin"
_prepend_path "$PKG/lua/bin"
_prepend_path "$PKG/python/bin"
_prepend_path "$PKG/perl/bin"
_prepend_path "$PKG/node/bin"

export PATH
unset -f _prepend_path
