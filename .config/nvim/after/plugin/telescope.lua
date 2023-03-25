local builtin = require('telescope.builtin')

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>" )
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>o", "<cmd>Telescope oldfiles<cr>")
vim.keymap.set("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
vim.keymap.set("n", "<leader>gf", "<cmd>Telescope git_files<cr>")
vim.keymap.set("n", "<leader>gm", "<cmd>Telescope git_commits<cr>")
vim.keymap.set("n", "<leader>kk", "<cmd>Telescope keymaps<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
