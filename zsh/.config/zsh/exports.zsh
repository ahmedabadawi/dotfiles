# Environment variables and PATH setup.

export EDITOR="nvim"
export VISUAL="nvim"
export LANG="en_US.UTF-8"
export PAGER="less"

# --- GNU tools over BSD (Linux parity) -------------------------------------
# Homebrew keg-only formulae expose a "gnubin" dir with unprefixed GNU
# command names (coreutils' `ls`/`sed`/`sort`/etc, not `gls`/`gsed`/...).
# Prepending these makes plain `ls`, `sed`, `grep`, `find`, `awk`, `tar`
# resolve to the GNU implementation everywhere, matching Linux behavior
# (flags, output formatting, exit codes) instead of macOS's BSD userland.
typeset -a _gnubin_pkgs=(coreutils findutils gnu-sed grep gawk gnu-tar)
for _pkg in $_gnubin_pkgs; do
  _gnubin="$HOMEBREW_PREFIX/opt/$_pkg/libexec/gnubin"
  [ -d "$_gnubin" ] && path=("$_gnubin" $path)
done
unset _pkg _gnubin

# GNU man pages to match (gnuman dirs), appended after the gnubin loop.
typeset -a _gnuman_pkgs=(coreutils findutils gnu-sed grep gawk gnu-tar)
for _pkg in $_gnuman_pkgs; do
  _gnuman="$HOMEBREW_PREFIX/opt/$_pkg/libexec/gnuman"
  [ -d "$_gnuman" ] && export MANPATH="$_gnuman:$MANPATH"
done
unset _pkg _gnuman _gnubin_pkgs _gnuman_pkgs

# --- fzf ---------------------------------------------------------------
export FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"

# --- bat -------------------------------------------------------------------
# One of bat's built-in themes; no extra install step needed (unlike the
# Catppuccin bat theme, which requires downloading a .tmTheme file).
export BAT_THEME="Monokai Extended"
