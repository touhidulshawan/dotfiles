-- For Gruvbox Colorscheme
vim.o.background = "dark"
vim.g.gruvbox_contrast_dark = "hard"
-- vim.g.gruvbox_transparent_bg = 0

local colorscheme = "gruvbox"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end
