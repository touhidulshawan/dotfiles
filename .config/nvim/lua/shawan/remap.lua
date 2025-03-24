local keymap = vim.keymap.set
local option = { noremap = true, silent = true }

-- map the leader key
keymap("", "<Space>", "<Nop>", option)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- file browser (netrw)
keymap("n", "<leader>e", "<cmd>:Lexplore<CR>" , option )

-- insert date on file
keymap('n', "t", "<cmd>:.!date<CR>", option)

keymap("n", "j", "gj", option)
keymap("n", "k", "gk", option)
keymap("i", "jj", "<esc>", option)

-- split navigation
keymap("n", "<C-h>", "<C-w>h", option)
keymap("n", "<C-j>", "<C-w>j", option)
keymap("n", "<C-k>", "<C-w>k", option)
keymap("n", "<C-l>", "<C-w>l", option)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", option)
keymap("n", "<C-Down>", ":resize +2<CR>", option)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", option)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", option)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", option)
keymap("n", "<S-h>", ":bprevious<CR>", option)

-- quick new file
keymap("n", "<Leader>n", "<cmd>enew<CR>", option)

-- easier file save
keymap("n", "<Leader>fs", "<cmd>:w<CR>", option)
keymap("n", "<leader>qf", "<cmd>:q<CR>", option)
keymap("n", "<leader>bk", "<cmd>:q<CR>", option)
-- Auto close tags
keymap("i", ",/", "</<C-X><C-O>", option)

-- After searching, pressing escape stops the highlight
keymap("n", "<esc>", ":noh<cr><esc>", option)
