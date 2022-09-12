local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "shawan.lsp.lsp-installer"
require("shawan.lsp.handlers").setup()
require("shawan.lsp.null-ls")
