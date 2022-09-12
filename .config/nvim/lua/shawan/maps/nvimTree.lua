local map = vim.api.nvim_set_keymap
local option = { noremap = true, silent = true }

map("n", "<leader>e", ":NvimTreeToggle<CR>", option)
map("n", "<leader>h", ":NvimTreeRefresh<CR>", option)
