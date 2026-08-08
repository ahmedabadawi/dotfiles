# ~/.zprofile — login shells, sourced once before .zshrc.
# Anything downstream tooling needs on PATH even in non-interactive
# login contexts (GUI-launched apps, launchd agents) belongs here.

# Homebrew — must come first, everything else assumes $HOMEBREW_PREFIX.
eval "$(/opt/homebrew/bin/brew shellenv)"

# pipx-installed CLIs
export PATH="$HOME/.local/bin:$PATH"
