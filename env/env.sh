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
export HOMEBREW_NO_ENV_HINTS

# App Settings



#########################################
# Languages
#########################################

# Polyglot package roots
PKG="$HOME/.local/pkg"

# ── Node.js / npm ──────────────────────────────────────────
export NPM_CONFIG_PREFIX="$PKG/node"
export NODE_PATH="$PKG/node/lib/node_modules"

# ── Rust / Cargo ───────────────────────────────────────────
export CARGO_HOME="$PKG/cargo"
export RUSTUP_HOME="$PKG/rustup"

# ── Python / pip ───────────────────────────────────────────
export PYTHONUSERBASE="$PKG/python" # Use: pip install --user (respects PYTHONUSERBASE automatically)

# ── Rust / Cargo ───────────────────────────────────────────
export LUA_PATH="$PKG/lua/share/lua/5.4/?.lua;;"
export LUA_CPATH="$PKG/lua/lib/lua/5.4/?.so;;"

# ── Rust / Cargo ───────────────────────────────────────────
export PERL_LOCAL_LIB_ROOT="$PKG/perl"
export PERL_MB_OPT="--install_base $PKG/perl"
export PERL_MM_OPT="INSTALL_BASE=$PKG/perl"
export PERL5LIB="$PKG/perl/lib/perl5"

# ── Rust / Cargo ───────────────────────────────────────────
export GOPATH="$PKG/go"

# PATH additions — guard against duplicate entries
_prepend_path() {
    case ":$PATH:" in
        *":$1:"*) ;;          # already present, skip
        *) PATH="$1:$PATH" ;;
    esac
}

_prepend_path "$PKG/node/bin"
_prepend_path "$PKG/cargo/bin"
_prepend_path "$PKG/python/bin"
_prepend_path "$PKG/lua/bin"
_prepend_path "$PKG/perl/bin"
_prepend_path "$PKG/go/bin"

export PATH
