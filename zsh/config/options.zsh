#
# options.zsh — core shell behavior: navigation, history, and globbing.
#

# --- Navigation ----------------------------------------------------------------
setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd/popd.
setopt CORRECT              # Spelling correction for commands.
setopt CDABLE_VARS          # `cd` to a path stored in a variable, e.g. `cd DOTFILES`.
setopt EXTENDED_GLOB        # Enable extended globbing syntax (e.g. `^`, `~`, `#`).

# --- History ---------------------------------------------------------------------
HISTFILE="$ZDOTDIR/.zsh_history"   # Where history is saved
HISTDUP=erase
HISTSIZE=5000                      # Max events kept in memory
SAVEHIST=$HISTSIZE                 # Max events saved to disk
HISTTIMEFORMAT="[%F %T]"

setopt APPEND_HISTORY             # Append to the history file, don't overwrite it.
setopt EXTENDED_HISTORY           # Save a timestamp + duration with each command.
setopt SHARE_HISTORY              # Share history live across all open sessions.
setopt HIST_EXPIRE_DUPS_FIRST     # Expire duplicates first when trimming history.
setopt HIST_IGNORE_DUPS           # Don't record a command identical to the previous one.
setopt HIST_IGNORE_ALL_DUPS       # Remove the older copy when a duplicate is recorded.
setopt HIST_FIND_NO_DUPS          # Don't show duplicates when searching history.
setopt HIST_IGNORE_SPACE          # Don't record commands that start with a space.
setopt HIST_SAVE_NO_DUPS          # Don't write duplicate commands to the history file.
