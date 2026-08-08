# ~/.zshenv — sourced for every zsh invocation (interactive, scripts, etc).
# Keep this minimal: only things every shell needs, even non-login ones.

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
