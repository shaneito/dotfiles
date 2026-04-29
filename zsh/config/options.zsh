#       ____        _   _                           _
#      / __ \      | | (_)                         | |
#     | |  | |_ __ | |_ _  ___  _ __  ___   _______| |__
#     | |  | | '_ \| __| |/ _ \| '_ \/ __| |_  / __| '_ \
#     | |__| | |_) | |_| | (_) | | | \__ \_ / /\__ \ | | |
#      \____/| .__/ \__|_|\___/|_| |_|___(_)___|___/_| |_|
#            | |


# +--------------+
# | NAVIGATION   |
# +--------------+

setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

setopt CORRECT              # Spelling correction
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB        # Use extended globbing syntax.


# +---------+
# | HISTORY |
# +---------+

HISTFILE="$ZDOTDIR/.zsh_history" # History filepath
HISTDUP=erase
HISTSIZE=5000                   # Maximum events for internal
SAVEHIST=$HISTSIZE
HISTTIMEFORMAT="[%F %T]"

setopt appendhistory
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt sharehistory             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt hist_ignore_dups          # Do not record an event that was just recorded again.
setopt hist_ignore_all_dups      # Delete an old recorded event if a new event is a duplicate.
setopt hist_find_no_dups         # Do not display a previously found event.
setopt hist_ignore_space         # Do not record an event starting with a space.
setopt hist_save_no_dups         # Do not write a duplicate event to the history file.
