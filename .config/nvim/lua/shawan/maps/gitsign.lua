local map = vim.api.nvim_set_keymap
local options = { noremap = true, silent = true }

map("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", options)
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", options)
map("n", "<leader>gl", "<cmd>Gitsigns toggle_linehl<cr>", options)
map("n", "<leader>gc", "<cmd>G commit<cr>", options)
map("n", "<leader>gp", "<cmd>G push<cr>", options)
