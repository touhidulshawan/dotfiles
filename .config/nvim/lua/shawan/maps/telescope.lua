local map = vim.api.nvim_set_keymap
local option = { noremap = true }

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", option)
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", option)
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", option)
map("n", "<leader>o", "<cmd>Telescope oldfiles<cr>", option)
map("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", option)
map("n", "<leader>gf", "<cmd>Telescope git_files<cr>", option)
map("n", "<leader>gm", "<cmd>Telescope git_commits<cr>", option)
map("n", "<leader>kk", "<cmd>Telescope keymaps<cr>", option)
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", option)
