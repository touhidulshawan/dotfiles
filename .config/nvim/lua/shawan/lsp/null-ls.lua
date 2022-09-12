local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics
local completion = null_ls.builtins.completion

local code_action = null_ls.builtins.code_actions.gitsigns
local hover = null_ls.builtins.hover

null_ls.setup({
	debug = false,
	sources = {
		formatting.eslint,
		formatting.prettier.with({ extra_filetypes = { "toml" } }),
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
		formatting.codespell.with({ filetypes = { "markdown" } }),
		formatting.fish_indent,
		formatting.rustfmt,
		formatting.shfmt,
		completion.spell,
		code_action,
		hover.dictionary,
	},
})
