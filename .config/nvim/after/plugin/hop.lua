local map = vim.keymap.set

local option = { noremap = true }

require("hop").setup()
map("n", "<leader>j", "<cmd>lua require'hop'.hint_words()<cr>", option)
map("n", "<leader>l", "<cmd>lua require'hop'.hint_lines()<cr>", option)
map("v", "<leader>j", "<cmd>lua require'hop'.hint_words()<cr>", option)
map("v", "<leader>l", "<cmd>lua require'hop'.hint_lines()<cr>", option)
