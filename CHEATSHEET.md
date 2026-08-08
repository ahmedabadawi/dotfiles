# Keybinding Cheatsheet

Shortcuts configured in this repo, grouped by tool. `<leader>` is `Space`
everywhere below (set in `nvim/.config/nvim/lua/config/options.lua`).

## Neovim

### General
| Key | Action |
|---|---|
| `<leader>w` | Save file |
| `<leader>q` | Quit |
| `<leader>ss` | Toggle spellcheck |
| `Esc` | Clear search highlight |
| `<leader>f` | Format buffer (conform.nvim) |

### Windows
| Key | Action |
|---|---|
| `Ctrl-h` / `Ctrl-j` / `Ctrl-k` / `Ctrl-l` | Move to window left/down/up/right |

### Visual mode
| Key | Action |
|---|---|
| `<` / `>` | Indent left/right, keeps selection |
| `J` | Move selected lines down |
| `K` | Move selected lines up |

### LSP (active once a language server attaches)
| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `K` | Hover docs |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>d` | Line diagnostics (float) |
| `[d` / `]d` | Previous/next diagnostic |

### Completion (insert mode, nvim-cmp)
| Key | Action |
|---|---|
| `Ctrl-Space` | Trigger completion |
| `Ctrl-e` | Abort completion |
| `Enter` | Confirm selection |
| `Tab` / `Shift-Tab` | Next/previous item, or expand/jump snippet |

### Telescope (fuzzy finder — replaces fzf.vim)
| Key | Action |
|---|---|
| `Ctrl-p` or `<leader>ff` | Find files |
| `<leader>fg` | Live grep (ripgrep) |
| `<leader>fb` | List open buffers |
| `<leader>fh` | Search help tags |
| `<leader>fr` | Recent files |
| `<leader>fd` | Diagnostics list |

### File explorer (nvim-tree — replaces NERDTree)
| Key | Action |
|---|---|
| `Ctrl-\` | Toggle file explorer |

### Git (gitsigns.nvim — replaces vim-gitgutter)
| Key | Action |
|---|---|
| `]h` / `[h` | Next/previous hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |

### Comment.nvim (default keymaps, not custom-remapped)
| Key | Action |
|---|---|
| `gcc` | Toggle line comment |
| `gc` (visual) | Toggle comment on selection |
| `gbc` | Toggle block comment |
| `gco` / `gcO` | Insert comment below/above and enter insert mode |

### which-key.nvim
Press `<leader>` (or any prefix key) and wait — a popup lists every
available completion for that prefix, so the tables above don't need to
be memorized.

---

## tmux

Prefix: `Ctrl-b` (default, unchanged).

| Key | Action |
|---|---|
| `Prefix` `\|` | Split pane vertically (side by side) |
| `Prefix` `-` | Split pane horizontally (stacked) |
| `Prefix` `h`/`j`/`k`/`l` | Move to pane left/down/up/right |
| `Prefix` `r` | Reload `~/.tmux.conf` |
| Mouse | Click to select pane/window, drag to resize, scroll for copy-mode |

### Copy mode (vi-style — `mode-keys vi`)
| Key | Action |
|---|---|
| `Prefix` `[` | Enter copy mode |
| `v` | Begin selection |
| `y` | Copy selection to system clipboard (pbcopy, or xclip/xsel on Linux) and exit copy mode |

---

## zsh

Emacs-style bindings (`bindkey -e`), plus explicit sequences for
terminal keys that don't always map correctly out of the box:

| Key | Action |
|---|---|
| `Ctrl-Right` / `Ctrl-Left` | Jump forward/backward one word |
| `Ctrl-Delete` | Delete word forward |
| `Ctrl-Backspace` | Delete word backward |
| `Home` / `End` | Jump to start/end of line |
| `Delete` | Delete character under cursor |
| `Option-Left` / `Option-Right` (Alacritty) | Same as Ctrl-Left/Right — `option_as_alt = "Both"` in `alacritty.toml` sends the standard word-jump escape codes |

### Aliases & functions
| Command | Runs |
|---|---|
| `ls` / `ll` / `lt` | `eza` (plain / long+git / tree) |
| `cat` / `catn` | `bat` (plain-style / with line numbers & git markers) |
| `grep` | GNU `grep --color=auto` |
| `g` | `git` |
| `vim` / `vi` | `nvim` |
| `mkcd <dir>` | `mkdir -p` + `cd` in one step |
| `y` | Launch `yazi`; `cd`s your shell into wherever you navigated to on exit |
| `jl` | Activate ml-playground venv + `jupyter lab` |

---

## git (aliases from `git/.gitconfig`)

| Alias | Runs |
|---|---|
| `git co` | `checkout` |
| `git br` | `branch` |
| `git st` | `status -sb` |
| `git cm` | `commit -m` |
| `git amend` | `commit --amend --no-edit` |
| `git unstage` | `restore --staged` |
| `git please` | `push --force-with-lease` |
| `git undo` | `reset --mixed HEAD~1` |
| `git lg` | Graph log, one line per commit with author/date |

---

## Reference: tool defaults (not customized here)

These weren't configured by this repo — listed for convenience since
they're part of the toolset.

### Alacritty (macOS built-in bindings)
| Key | Action |
|---|---|
| `Cmd-N` | New window |
| `Cmd-T` | New tab (if enabled by macOS window server) |
| `Cmd-C` / `Cmd-V` | Copy / paste |
| `Cmd-+` / `Cmd--` / `Cmd-0` | Increase / decrease / reset font size |
| `Cmd-K` | Clear scrollback |

### yazi (default keymap, no custom `keymap.toml` in this repo)
| Key | Action |
|---|---|
| `h` / `j` / `k` / `l` | Left/down/up/right (parent dir / move / move / enter dir) |
| `Enter` | Open file / enter directory |
| `Space` | Toggle selection |
| `d` | Trash selected |
| `y` / `p` | Yank / paste |
| `q` | Quit (respects the `y` shell wrapper's cd-on-exit) |
