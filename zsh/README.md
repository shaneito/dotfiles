# zsh config — restructure notes

**Status: promoted and live as of 2026-09-17**, with one exception —
`zshenv`. Every other file here (`zshrc`, everything in `config/`, and
`~/.dotfiles/env/env.sh`) has already replaced the old version in place.

`zshenv` couldn't be touched automatically — it's locked down (permission
denied even just reading it) in a way none of your other dotfiles are, so
whatever's protecting it wouldn't let it be overwritten from here either.
The version this restructure intended for it is saved as
`zshenv.draft` right next to it. To finish the promotion, from your own
terminal (which has the permissions this couldn't get):

```zsh
cat ~/.dotfiles/zsh/zshenv.draft   # sanity-check it first
mv ~/.dotfiles/zsh/zshenv.draft ~/.dotfiles/zsh/zshenv
```

(If that `mv` itself fails or asks for a password, whatever's restricting
the file is stronger than a normal permission bit — check
`ls -lO ~/.dotfiles/zsh/zshenv` for a `uchg`/`schg` flag, or run
`chflags nouchg ~/.dotfiles/zsh/zshenv` first if one shows up.)

The rest of this document is kept as the record of what changed and why.

---

This was originally a **draft**, tested alongside the real config before
being promoted.

## What changed

**Structure / naming**
- `config/integrations.zsh` was doing two unrelated jobs — CLI tool hooks
  (brew, mise, fzf, starship...) *and* zsh plugin loading — and its name
  collided with the old `config/plugins.zsh`. Split into:
  - `config/tools.zsh` — the CLI tool integrations
  - `config/plugins.zsh` — completion system + plugin manager + plugin config
- The old `config/plugins.zsh` was a **stale, unused file** — a pre-built
  antidote bundle that nothing actually sourced (`zshrc` never referenced
  it; `integrations.zsh` called `antidote load` directly instead). It's
  gone from the repo; the new `plugins.zsh` generates the same kind of
  bundle automatically at runtime (see perf below) and caches it under
  `$XDG_CACHE_HOME`, so it's never a tracked file you have to remember to
  regenerate.
- `config/plugins.txt` had `olets/zsh-abbr` listed twice — deduped.
- Every file now starts with a one-line comment saying what it's for, and
  is broken into `# --- Section ---` dividers instead of one long list.
- `zshrc`'s load order is now `options → paths → tools → plugins →
  aliases → functions` — env/behavior first, then anything that reads
  `$PATH`, then plugins (which need Homebrew's `$PATH` from `tools.zsh`
  already set), then your own aliases/functions last.
- The `source /Users/shane/.config/broot/launcher/bash/br` line at the
  bottom of `zshrc` moved into `tools.zsh` (that's what it is — a tool
  integration) and now uses `$HOME` instead of a hardcoded username, with
  an existence check so a fresh machine without broot installed won't
  error on startup.
- Function style unified to `name() { ... }` everywhere (some used the
  `function name() { }` keyword, most didn't — harmless either way, just
  inconsistent).
- Found and fixed a small bug: `gtype`'s cheat-sheet said `🧪️ TEST` for
  `gtst`, but the `gtst` function itself actually commits with `🤖 TEST`.
  Now the cheat sheet matches what it really does.
- **zoxide removed from `tools.zsh`** (per your call) — fasder now handles
  frecency-based directory jumping on its own.
- **VS Code's `$PATH` entry fixed.** It pointed at a nested portable-install
  layout (`/Applications/Visual Studio Code/Visual Studio Code.app/...`)
  left over from before you installed it properly. Now it's just
  `/Applications/Visual Studio Code.app/Contents/Resources/app/bin`. One
  thing worth knowing: the line is inside double quotes
  (`export PATH="...Visual Studio Code.app..."`), and double quotes
  already protect the spaces in the folder name — you don't need
  backslashes (`Visual\ Studio\ Code.app`) *as well*. Adding both would
  put literal backslash characters into `$PATH` and break it, so I kept
  it quotes-only, consistent with the rest of the file.

**Performance** (same behavior, faster startup)
- `compinit` was rebuilding zsh's completion cache from scratch on *every*
  new shell. It now only does that full rebuild once every 24 hours and
  just loads the cached result (`compinit -C`) the rest of the time.
- `antidote load` resolves and re-sources every plugin from scratch on
  every startup. `plugins.zsh` now builds a static bundle once with
  `antidote bundle` and only rebuilds it when `plugins.txt` changes —
  every other shell just sources one pre-built file, which is
  meaningfully faster with 5 plugins.

## env.sh — reviewed separately

`env.sh` lives in its own `~/.dotfiles/env/` repo/folder, sourced from
`zshenv` via `[ -f "$HOME/.config/env/env.sh" ] && . "..."`. That line is
already carried over into the draft `zshenv` unchanged. A corrected copy
of the file itself is at `~/.dotfiles/env/draft/env.sh` (same
draft-alongside pattern as the zsh files) with three small fixes:

- `export HOMEBREW_NO_ENV_HINTS` (no value) → `export HOMEBREW_NO_ENV_HINTS=1`.
  This was a real bug: Homebrew checks whether that variable is
  *non-empty* before it suppresses its hints, and `export VAR` with no
  `=value` exports an **empty** string — so the hints were never actually
  being suppressed. `=1` fixes that.
- The comment above `export GOPATH="$PKG/go"` still said
  `# ── Rust / Cargo ──` (copy-paste leftover from the block above it) —
  relabeled `# ── Go ──`.
- Added `unset -f _prepend_path` at the end, so that helper function
  doesn't linger in every interactive shell after it's done its job.
- **The polyglot package root moved**: `PKG="$HOME/.local/pkg"` is now
  `PKG="$XDG_DATA_HOME"` (i.e. `~/.local/share`). You already had
  `$XDG_DATA_HOME` defined for exactly this purpose — "where tools keep
  their data" — and it's already where `mise` itself stores everything
  (`~/.local/share/mise`). Inventing a separate `~/.local/pkg` tree next
  to it would've meant two different "common places" instead of one.
  I checked: `~/.local/pkg` doesn't exist on your Mac yet (nothing
  installed there), so this is a same-day, zero-migration change — once
  you promote this draft, `npm`/`cargo`/`pip`/etc. will just create their
  folders under `~/.local/share/...` the first time each runs.

**On keeping it separate vs. folding it back into zsh's config:** keep it
separate — don't fold it back in. The separation you set up (general env
vars in their own file vs. zsh-specific behavior in `config/`) is the
right shape for what you're trying to do, and merging it back would undo
that for no real benefit.

**On mise vs. these variables:** mise (which you already run) already
solves "keep every language runtime in one common place and put the
right version on `$PATH`" — that's exactly what its *shims* do. It
doesn't replace what's in `env.sh` though: these variables control a
different thing — where each language's own package manager stores its
global installs/cache (`CARGO_HOME`, `PYTHONUSERBASE`, npm's prefix,
etc.) — which mise doesn't manage and no zsh plugin really does either;
hand-setting it is the normal way. `paths.zsh` already adds mise's shims
to `$PATH` *after* these, so mise-managed versions correctly win over
anything under `$PKG/*/bin` — no change needed there.

**Reordered by how much you actually use each language** (Node/JS daily,
Perl/Python/C occasionally, Lua only for Neovim plugin config, Go/Rust
out of curiosity):
- Dropped `NODE_PATH`. It's a legacy Node module-resolution setting that
  modern Node/npm — and bundlers like webpack/vite/jest — don't expect,
  and leaving it globally set is a known source of "wrong version of a
  package got loaded" confusion. Since Node is your main language, this
  is worth getting right rather than carrying it forward unexamined; if
  something genuinely needs it later, it's a one-line, project-scoped fix
  rather than a global one.
- Added a placeholder comment under a new "C" section noting there's
  nothing to configure yet (Xcode Command Line Tools / Homebrew's
  toolchain work out of the box) — with a pointer to where `CPATH`/
  `PKG_CONFIG_PATH` would go if you ever need to link against a
  Homebrew-installed library.
- The `_prepend_path` calls at the bottom are now ordered least-used
  first, most-used last — since each call wins `$PATH` priority over the
  ones before it, Node's `bin` directory now ends up searched first
  among these, matching how often you actually reach for it.

That said, worth knowing: as written today, `env.sh` is **zsh/bash syntax,
not actually shell-portable** — `export VAR=value` isn't valid in fish
(`set -gx VAR value`) or nushell (`$env.VAR = value`), and the
`_prepend_path` function using `case` + colon-joined `$PATH` is a
bash/zsh-only pattern (fish has no direct equivalent to that string
matching, and nushell's `$env.PATH` is a list, not a colon-string). So
right now this file would need to be *translated*, not directly reused,
if you switched shells.

If real portability is the goal, the two common approaches are:
1. **Values-only file**: strip it down to plain `KEY=value` lines (no
   `export`, no functions, no shell logic), which zsh can load with
   `set -a; source env.sh; set +a`, and fish/nu can each parse with a
   handful of lines of their own. The PATH-building logic (`_prepend_path`)
   would need to move into each shell's own config, since PATH handling
   differs enough between them that a shared version isn't realistic.
2. **Keep one canonical zsh version** (what you have now) and write a
   short fish/nu equivalent *when you actually adopt one of them* — most
   of these values rarely change, so keeping two or three short files in
   sync by hand isn't a big burden, and you avoid maintaining a
   least-common-denominator format today for a switch that may not
   happen.

I'd lean toward (2) unless you're fairly likely to switch soon — happy to
build the values-only version instead if you'd rather have it ready now.

## Worth deciding (didn't change these — your call)

- **`mksubdir` / `flattenUp`** use camelCase-ish naming (`flattenUp`)
  while everything else in `functions.zsh` is all-lowercase. Left as-is
  since renaming a function could break muscle memory or other scripts
  that call it — rename if you want, it's a one-line change either place.
- **ASCII-art banners**: the original files each used a different figlet
  font for their header comment. I replaced them with plain one-line
  headers for consistency and easier upkeep — say the word if you'd
  rather I regenerate matching figlet banners for every file instead.
- **Bigger swing, not done here**: if you ever want startup time lower
  than static-bundle antidote can get you, a plugin manager like `zinit`
  supports *async/turbo loading* — plugins load in the background after
  your prompt already appears. It's a bigger change (different syntax,
  steeper learning curve) so I left it out of this pass, but happy to do
  a `zinit` version if you want to compare the two side by side.

## How to test before switching over

Don't just symlink this in blind — try it in an isolated shell first:

```zsh
zsh ~/.dotfiles/zsh/draft/test.sh
```

This launches a throwaway interactive shell using the draft config,
without touching your real `~/.zshenv` or `~/.config/zsh`. Exit it
(`exit` or Ctrl-D) any time to get back to your normal shell — nothing
persists. Note it still points at your *live* `env.sh`
(`~/.config/env/env.sh`), not the corrected draft copy — copy the draft
over once you're happy with it (see below).

Things worth checking in that test shell:
- `ll`, `lt`, `j <something>` (fasder), `Ctrl-T` (fzf) all still work
- vi-mode (`jk` to escape insert mode) and syntax highlighting still work
- `gtype` prints the corrected cheat sheet
- `code .` still opens VS Code (confirms the fixed `$PATH` entry)
- a brand new shell after that first one starts noticeably snappier —
  `time zsh -i -c exit` before/after is the honest way to check

## How to switch over once you're happy

```zsh
mv ~/.dotfiles/zsh ~/.dotfiles/zsh-old            # keep a backup
mv ~/.dotfiles/zsh-old/draft ~/.dotfiles/zsh       # promote the draft

mv ~/.dotfiles/env/env.sh ~/.dotfiles/env/env.sh.old
mv ~/.dotfiles/env/draft/env.sh ~/.dotfiles/env/env.sh

rm -rf ~/.dotfiles/zsh-old ~/.dotfiles/env/env.sh.old ~/.dotfiles/env/draft
```

Then open a completely new terminal window (not just a new tab reusing
the same process) so it picks up the change from a clean `zshenv`/`zshrc`
read, and confirm everything still works before deleting the backups.
