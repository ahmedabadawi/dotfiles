# Dev toolchain setup — versioned here (nothing secret) so a fresh
# machine gets the same toolchains without re-wiring them by hand.
# Anything truly machine-specific and *not* wanted in the repo can go in
# ~/.config/zsh/local.zsh.private (gitignored, sourced last if present).

# --- nvm ---------------------------------------------------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && source "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"

# --- sdkman --------------------------------------------------------------
# THIS MUST STAY LAST IN THIS FILE — sdkman's own install instructions
# require it to be the final thing sourced for its shell integration to work.
export SDKMAN_DIR="$HOME/.sdkman"
[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# --- pyenv -------------------------------------------------------------
if command -v pyenv >/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  path=("$PYENV_ROOT/bin" $path)
  eval "$(pyenv init -)"
fi

# --- LaTeX (BasicTeX/MacTeX) ------------------------------------------
[ -d /Library/TeX/texbin ] && export PATH="/Library/TeX/texbin:$PATH"

# --- misc personal aliases -----------------------------------------------
alias jl="source ~/.venvs/ml-playground/bin/activate && jupyter lab"

[ -f "$HOME/.config/zsh/local.zsh.private" ] && source "$HOME/.config/zsh/local.zsh.private"
