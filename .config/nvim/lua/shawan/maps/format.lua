local map = vim.api.nvim_set_keymap

local option = { noremap = true, silent = true }

map("n", "<leader>ft", "<cmd>Format<cr>", option)
