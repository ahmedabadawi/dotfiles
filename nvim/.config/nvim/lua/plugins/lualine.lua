-- Replaces lightline.vim.
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    options = {
      theme = "catppuccin-mocha",
      globalstatus = true,
      icons_enabled = true,
    },
  },
}
