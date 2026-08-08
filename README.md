# dotfiles

My macOS configuration, built to feel as close to a Linux dev environment
as practical: GNU coreutils/findutils/sed/grep/awk take priority over
BSD, the shell is plain zsh (no framework) with a minimal prompt, and
everything is managed with [GNU Stow](https://www.gnu.org/software/stow/)
so a new machine is one command away from being set up.

## Structure

Each top-level directory is a Stow "package" that mirrors the `$HOME`
layout it targets — e.g. `zsh/.zshrc` symlinks to `~/.zshrc`,
`nvim/.config/nvim/init.lua` symlinks to `~/.config/nvim/init.lua`.

```
.
├── Brewfile        # brew bundle — every CLI tool/cask this setup needs
├── install.sh      # bootstraps a new machine: brew bundle + stow
├── zsh/            # shell config, GNU tools PATH, aliases, prompt wiring
├── nvim/            # Neovim (Lua, lazy.nvim)
├── git/            # ~/.gitconfig + global gitignore
├── tmux/            # terminal multiplexer config
├── alacritty/       # terminal emulator config
└── starship/        # prompt config
```

## Quick start (new machine)

```sh
xcode-select --install   # if not already present
git clone git@github.com:ahmedabadawi/dotfiles.git ~/projects/personal/dotfiles
cd ~/projects/personal/dotfiles
./install.sh
```

`install.sh` will:
1. Install Homebrew if it's missing.
2. Run `brew bundle` against the `Brewfile` (installs `stow` itself, plus
   everything else below).
3. Back up any pre-existing real dotfiles it would otherwise clobber into
   `~/.dotfiles_backup/<timestamp>/`.
4. Symlink every package into `$HOME` with `stow`.
5. Headlessly install all Neovim plugins (fast — just `git clone`s).

Re-running `./install.sh` any time (e.g. after `git pull`) is safe —
it's idempotent.

## Next steps after `./install.sh`

1. **Open a new terminal** (or run `exec zsh`) to pick up the new shell
   config.
2. **Open Neovim once, interactively, to finish LSP setup.** `install.sh`
   only bootstraps *plugins* headlessly — it deliberately can't finish
   the LSP servers. `mason-lspconfig` (which installs pyright, ruff,
   ts_ls, bashls, dockerls, docker_compose_language_service, yamlls,
   lua_ls, rust_analyzer, jdtls, jsonls, and taplo) skips its
   `ensure_installed` step whenever Neovim runs headless, by design — so
   those 12 servers are only queued for download the first time you open
   `nvim` for real.
   - Just open any file (`nvim somefile.py`, etc.) — downloads start
     automatically in the background, no action needed.
   - Expect a short pause/spinner the first time an LSP-backed feature
     (hover, diagnostics, completion) is used on a given language before
     its server has finished downloading.
   - Check progress any time with `:Mason` (package manager UI) or
     `:LspInfo` (status for the current buffer).
   - Treesitter parsers and the formatters/linters (stylua, shfmt,
     shellcheck, prettier, ruff, eslint_d, hadolint, yamllint, taplo)
     *are* already fully installed by `install.sh` — only the LSP
     servers proper are deferred.
3. **Verify GNU tools won and PATH has no surprises**: `which sed` should
   print a path under `.../gnu-sed/libexec/gnubin/sed`, and `sed --version`
   should say `(GNU sed)`. If a shell was open before you ran
   `install.sh`, it won't have picked up the change — open a new one.
4. Skim [`CHEATSHEET.md`](./CHEATSHEET.md) for the keybindings across
   Neovim/tmux/zsh/git.

## What's installed

| Tool | Replaces | Purpose |
|---|---|---|
| Neovim (Lua, lazy.nvim) | Vim + vim-plug | editor |
| telescope.nvim | fzf.vim | fuzzy finder |
| nvim-tree.lua | NERDTree | file explorer |
| lualine.nvim | lightline.vim | statusline |
| gitsigns.nvim | vim-gitgutter | git gutter/hunks |
| conform.nvim + nvim-lint | ale | formatting + linting |
| mason.nvim + nvim-lspconfig | — | LSP (Python, TS/JS, Bash, Docker/YAML, Lua, Rust, Java, JSON, TOML) |
| eza / bat / fd / ripgrep / zoxide | ls / cat / find / grep / cd | modern CLI replacements |
| yazi | — | terminal file manager |
| starship | — | shell prompt |
| git-delta | — | git diff pager |
| GNU coreutils/findutils/gnu-sed/grep/gawk | BSD equivalents | Linux-parity command behavior |

Full package list is in the [`Brewfile`](./Brewfile). Keybindings for
Neovim, tmux, zsh, and git are in [`CHEATSHEET.md`](./CHEATSHEET.md).

## Managing individual packages

```sh
stow -t ~ <package>       # (re)link one package
stow -D -t ~ <package>    # unlink one package
stow -R -t ~ <package>    # restow (unlink + relink), safe after edits
```

## Customization

- `zsh/.config/zsh/local.zsh` — versioned dev-toolchain wiring (nvm,
  sdkman, pyenv, cargo, LaTeX). Nothing secret; safe to commit.
- `zsh/.config/zsh/local.zsh.private` — optional, **gitignored**, sourced
  last if present. Use it for anything truly machine-specific you don't
  want in the repo.

## Credits

Originally inspired by [dougblack.io's "A Good Vimrc"](https://dougblack.io/words/a-good-vimrc.html) — the repo has
since moved well past a single `.vimrc`.
