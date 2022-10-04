local map = vim.api.nvim_set_keymap

local option = { noremap = true, silent = true }

map("n", "<leader>ft", "<cmd>lua vim.lsp.buf.format()<cr>", option)

vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
