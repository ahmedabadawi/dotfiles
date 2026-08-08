# Aliases. Modern CLI replacements + a few Linux-parity conveniences.
#
# `rg` and `fd` are deliberately NOT aliased over `grep`/`find` — their
# flags and defaults differ enough from POSIX grep/find that aliasing
# would be surprising in scripts and wouldn't transfer to boxes where
# you don't control the shell. Use them directly by name instead.

# --- eza (replaces ls) ------------------------------------------------------
alias ls='eza --group-directories-first'
alias ll='eza -lah --group-directories-first --git'
alias lt='eza --tree --level=2 --group-directories-first'

# --- bat (replaces cat, for viewing) ----------------------------------------
alias cat='bat --paging=never --style=plain'
alias catn='bat --paging=never'   # with line numbers / git markers

# --- GNU grep is now on PATH (via exports.zsh) ------------------------------
alias grep='grep --color=auto'

# yazi's `y` cd-on-exit wrapper is defined as a function in functions.zsh
# (needs shell logic, not a plain alias).

# --- git shorthand (kept out of ~/.gitconfig aliases on purpose: these are
# shell-level, not `git <alias>` style) --------------------------------------
alias g='git'

# --- editor --------------------------------------------------------------
alias vim='nvim'
alias vi='nvim'

# --- misc Linux-y conveniences -----------------------------------------
alias df='df -h'
alias du='du -h'
alias mkdir='mkdir -p'
alias ..='cd ..'
alias ...='cd ../..'
