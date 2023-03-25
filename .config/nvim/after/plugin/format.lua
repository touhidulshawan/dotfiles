local option = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>ft", "<cmd>lua vim.lsp.buf.format{async = true}<cr>", option)
