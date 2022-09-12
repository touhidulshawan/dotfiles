local map = vim.api.nvim_set_keymap

map("n", "<leader>gs", ":G<CR>", {})
map("n", "<leader>gh", ":diffget //3<CR>", {})
map("n", "<leader>gu", ":diffget //2<CR>", {})
