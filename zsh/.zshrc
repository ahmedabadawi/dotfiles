# ~/.zshrc — interactive shells. Thin orchestrator: no framework
# (no oh-my-zsh), just plain zsh + a handful of sourced files.

# Keep the `path` array (and its linked $PATH) deduplicated — without
# this, every nested/re-sourced shell (tmux panes, `zsh -i -c`, etc.)
# accumulates duplicate entries indefinitely.
typeset -U path

# --- completions ------------------------------------------------------
# Homebrew's site-functions must be on fpath *before* compinit runs, or
# completions for brew-installed tools (eza, fd, rg, bat, zoxide, delta,
# starship...) silently don't load.
fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)

autoload -Uz compinit
# Only regenerate the completion cache once a day — keeps startup fast.
if [[ -n ${HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# --- history ------------------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# --- general shell options ----------------------------------------------
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS

# --- config files ---------------------------------------------------------
# `local.zsh` (pyenv/nvm/sdkman/LaTeX) is sourced *before* `exports.zsh` on
# purpose: those tools each prepend their own dirs to PATH, and exports.zsh
# prepends the GNU gnubin dirs — sourcing it last guarantees GNU sed/grep/
# find/awk/tar stay ahead of everything else on PATH, which is the whole
# point of this setup. (typeset -U path above also keeps it duplicate-free
# across re-sourced/nested shells.)
for f in local aliases functions exports; do
  [ -f "$HOME/.config/zsh/$f.zsh" ] && source "$HOME/.config/zsh/$f.zsh"
done

# --- keybindings ----------------------------------------------------------
# Emacs-style bindings are the default on virtually every Linux distro's
# bash/zsh — keep that instead of zsh's vi-mode default.
bindkey -e

bindkey '^[[1;5C' forward-word        # Ctrl-Right
bindkey '^[[1;5D' backward-word       # Ctrl-Left
bindkey '^[[3;5~' kill-word           # Ctrl-Delete
bindkey '^H'      backward-kill-word  # Ctrl-Backspace
bindkey '^[[H'    beginning-of-line   # Home
bindkey '^[[F'    end-of-line         # End
bindkey '^[[1~'   beginning-of-line   # Home (alt sequence)
bindkey '^[[4~'   end-of-line         # End (alt sequence)
bindkey '^[[3~'   delete-char         # Delete

# --- tool init (order matters, keep these last) --------------------------
command -v zoxide  >/dev/null && eval "$(zoxide init zsh)"
command -v fzf     >/dev/null && eval "$(fzf --zsh)"
command -v starship >/dev/null && eval "$(starship init zsh)"
