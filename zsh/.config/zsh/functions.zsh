# Shell functions — things that need actual logic, not a plain alias.

# Make a directory (including parents) and cd into it.
mkcd() {
  mkdir -p -- "$1" && cd -- "$1"
}

# yazi's recommended shell wrapper: launch the terminal file manager,
# and when it exits, cd the *current shell* into whatever directory you
# navigated to (yazi itself can't change its parent shell's cwd).
function y() {
  local tmp cwd
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
