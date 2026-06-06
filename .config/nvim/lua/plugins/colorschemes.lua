-- return {
--     "sainnhe/gruvbox-material",
--     enabled = true,
--     priority = 1000,
--     config = function()
--         vim.g.gruvbox_material_transparent_background = 1
--         vim.g.gruvbox_material_foreground = "mix"
--         vim.g.gruvbox_material_background = "hard"
--         vim.g.gruvbox_material_ui_contrast = "high"
--         vim.g.gruvbox_material_float_style = "bright"
--         vim.g.gruvbox_material_statusline_style = "material"
--         vim.g.gruvbox_material_cursor = "auto"
--         vim.g.gruvbox_material_visual = "reverse"
--         vim.cmd.colorscheme("gruvbox-material")
--     end,
-- }
-- rose-pine
return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		-- transparency
		require("rose-pine").setup({
		        styles = {
		          transparency = true,
		        },
		        highlight_groups = {
		          Normal = { bg = "NONE" },
		          NormalNC = { bg = "NONE" },
		          SignColumn = { bg = "NONE" },
		          NormalFloat = { bg = "NONE" },
		          FloatBorder = { bg = "NONE" },
		        },
		      })
		vim.cmd("colorscheme rose-pine")
	end
}
