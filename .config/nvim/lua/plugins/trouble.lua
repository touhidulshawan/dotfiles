local option = {silent = true, noremap = true}

vim.keymap.set("n", "<leader>xt", "<cmd>TroubleToggle<cr>", option)
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", option)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", option)
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", option)
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", option)
