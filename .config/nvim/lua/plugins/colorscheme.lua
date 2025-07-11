-- For Gruvbox Colorscheme
vim.o.background = "dark"
--[[ vim.g.gruvbox_transparent_bg = 0 ]]
--[[ vim.g.gruvbox_contrast_dark = "hard" ]]
-- config for gruvbox-material
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_foreground = "original" -- available value: ['material', 'mix', 'original']
vim.g.gruvbox_material_disable_italic_comment = 1
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_transparent_background = 1 -- to enable set 1
vim.g.gruvbox_material_visual =  "reverse"
vim.g.gruvbox_material_diagnostic_text_highlight =  1

--[[ local colorscheme = "gruvbox-material" ]]
local colorscheme = "solarized-osaka"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end
