local map = vim.api.nvim_set_keymap

local option = { noremap = true, silent = true }

map("n", "<leader>ft", "<cmd>lua vim.lsp.buf.format{async = true}<cr>", option)

-- vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format {async = true}]])
vim.cmd([[autocmd BufWritePre * undojoin | Neoformat]])
