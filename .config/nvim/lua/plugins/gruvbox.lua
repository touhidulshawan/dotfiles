-- add gruvbox
vim.o.background = "dark"
vim.g.gruvbox_contrast_dark = "hard"
return {
  { "morhetz/gruvbox" },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
