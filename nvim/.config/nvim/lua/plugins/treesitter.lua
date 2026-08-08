local parsers = {
  "bash",
  "python",
  "javascript",
  "typescript",
  "tsx",
  "lua",
  "vim",
  "vimdoc",
  "rust",
  "java",
  "json", -- also covers "jsonc" filetype (maps to the json parser)
  "toml",
  "yaml",
  "dockerfile",
  "markdown",
  "markdown_inline",
  "gitignore",
  "diff",
}

return {
  "nvim-treesitter/nvim-treesitter",
  -- "main" is the actively maintained rewrite, built for current Neovim
  -- core (0.11+). "master" (the old configs.setup()/ensure_installed API)
  -- is frozen and crashes on newer Neovim treesitter internals
  -- (LanguageTree:parse -> highlighter attempt to call 'range' on nil).
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    -- Block until installed (no-op/instant once already present) so a
    -- headless `install.sh` run finishes with every parser in place,
    -- instead of racing an async job that gets killed by `+qa`.
    require("nvim-treesitter").install(parsers):wait(5 * 60 * 1000)

    -- "main" no longer auto-attaches highlighting; start it per buffer.
    -- pcall because not every filetype has an installed/available parser.
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
