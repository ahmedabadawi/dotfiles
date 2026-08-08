#!/usr/bin/env bash
# Bootstrap this machine from the dotfiles repo:
#   git clone git@github.com:ahmedabadawi/dotfiles.git && cd dotfiles && ./install.sh
#
# Safe to re-run — backs up real files once, then just restows.
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES=(zsh nvim git tmux alacritty starship)
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d-%H%M%S)"
BACKED_UP=()

log()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!!\033[0m %s\n' "$*"; }

# --- 1. Homebrew -----------------------------------------------------------
if ! command -v brew >/dev/null 2>&1; then
  log "Homebrew not found, installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

# --- 2. Packages (installs `stow` itself, among everything else) -----------
log "Installing packages from Brewfile..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

# --- 3. Back up any real (non-symlink) files that would conflict -----------
# Stow refuses to symlink over an existing real file. Move anything in the
# way into $BACKUP_DIR, preserving its relative path, before the real stow run.
back_up_conflicts() {
  local pkg="$1" pkg_dir="$DOTFILES_DIR/$1"
  while IFS= read -r -d '' file; do
    local rel="${file#"$pkg_dir"/}"
    local target="$HOME/$rel"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
      mkdir -p "$(dirname "$BACKUP_DIR/$rel")"
      mv "$target" "$BACKUP_DIR/$rel"
      BACKED_UP+=("$rel")
    fi
  done < <(find "$pkg_dir" -type f -print0)
}

log "Checking for existing dotfiles that would conflict..."
for pkg in "${PACKAGES[@]}"; do
  back_up_conflicts "$pkg"
done

if [ "${#BACKED_UP[@]}" -gt 0 ]; then
  log "Backed up ${#BACKED_UP[@]} existing file(s) to $BACKUP_DIR:"
  printf '    %s\n' "${BACKED_UP[@]}"
else
  log "Nothing to back up."
fi

# --- 4. Symlink everything with GNU Stow ------------------------------------
log "Stowing packages: ${PACKAGES[*]}"
stow -v -R -t "$HOME" -d "$DOTFILES_DIR" "${PACKAGES[@]}"

# --- 5. Bootstrap Neovim plugins headlessly ---------------------------------
if command -v nvim >/dev/null 2>&1; then
  log "Installing Neovim plugins..."
  nvim --headless "+Lazy! sync" +qa || warn "Neovim plugin sync had issues — run :Lazy inside nvim to retry."
fi

# --- 6. Default shell --------------------------------------------------------
if [ "${SHELL:-}" != "$(command -v zsh)" ]; then
  warn "Default shell isn't zsh. Run: chsh -s \$(command -v zsh)"
fi

log "Done. Backups (if any): $BACKUP_DIR"
log "Open a new terminal (or run 'exec zsh') to pick up the new shell config."
