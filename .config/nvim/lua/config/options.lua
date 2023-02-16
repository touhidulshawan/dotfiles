-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local o = vim.o
local wo = vim.wo
local bo = vim.bo
local opt = vim.opt

opt.backup = false
o.exrc = true
o.termguicolors = true
o.shell = "/usr/bin/fish"
o.hlsearch = false
o.hidden = true
o.swapfile = false
wo.number = true
wo.relativenumber = true
o.errorbells = true
wo.spell = true
o.wildmenu = true
o.showmatch = true
o.incsearch = true
wo.foldenable = true
o.foldlevelstart = 10
wo.foldnestmax = 10
wo.foldmethod = "indent"
o.smarttab = true
o.cindent = true
bo.tabstop = 4
bo.softtabstop = 4
o.shiftwidth = 4
bo.expandtab = true
o.smartcase = true
bo.smartindent = true
o.scrolloff = 8
wo.colorcolumn = "80"
o.textwidth = 80
bo.wrapmargin = 2
wo.signcolumn = "yes"
o.encoding = "utf-8"
opt.clipboard = "unnamedplus"
opt.wrap = true
opt.spelllang = "en"
opt.numberwidth = 5
opt.linebreak = true
opt.backspace = { "indent", "eol", "start" }
opt.completeopt = "menuone,noselect"
opt.splitright = true
opt.splitbelow = true
opt.conceallevel = 0
opt.pumheight = 10

vim.cmd("autocmd InsertEnter * norm zz")
vim.cmd([[set mouse=]])
vim.g.python3_host_prog = "/home/shawan/.virtualenvs/myPy/bin/python"
