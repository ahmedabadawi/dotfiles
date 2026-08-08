-- Core editor options.
local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Indentation: 2 spaces, matches the old .vimrc's convention.
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.smartindent = true
opt.autoindent = true

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.scrolloff = 7
opt.signcolumn = "yes"
opt.termguicolors = true
opt.splitright = true
opt.splitbelow = true
opt.wrap = false
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Files
opt.autoread = true
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("state") .. "/undo"

-- Behavior
opt.hidden = true
opt.mouse = "a"
opt.updatetime = 250
opt.timeoutlen = 400
opt.completeopt = { "menu", "menuone", "noselect" }
opt.clipboard = "unnamedplus"

-- Encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
