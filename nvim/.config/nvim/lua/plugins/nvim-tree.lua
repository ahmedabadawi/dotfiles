-- Replaces NERDTree.
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
  keys = {
    { "<C-\\>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
  },
  opts = {
    filters = { dotfiles = false }, -- show hidden files by default (old .vimrc did too)
    view = { width = 32 },
    renderer = { group_empty = true },
    git = { enable = true },
  },
}
