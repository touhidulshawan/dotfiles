local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever save this file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	use("wbthomason/packer.nvim")

	-- Essentials
	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim")
	use("BurntSushi/ripgrep")
	use("kyazdani42/nvim-web-devicons")

	-- lsp
	use("neovim/nvim-lspconfig")
	use("nvim-lua/lsp-status.nvim")
	use("onsails/lspkind-nvim")
	use("williamboman/nvim-lsp-installer")
	use("tamago324/nlsp-settings.nvim")
	use("jose-elias-alvarez/null-ls.nvim")

	-- cmp
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("saadparwaiz1/cmp_luasnip")
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")

	-- code formatter
	use("sbdchd/neoformat")

	-- other plugins
	use("tpope/vim-fugitive")
	use("phaazon/hop.nvim")
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	use("nvim-telescope/telescope.nvim")
	use("hoob3rt/lualine.nvim")
	use("windwp/nvim-autopairs")
	use("numToStr/Comment.nvim")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("alvan/vim-closetag")
	use({
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		after = "nvim-treesitter",
	})
	use("norcalli/nvim-colorizer.lua")

	-- colorscheme
	-- use("sainnhe/gruvbox-material")
	-- use 'Mofiqul/dracula.nvim'
	use("gruvbox-community/gruvbox")

	-- other plugins
	use("folke/lsp-colors.nvim")
	use("lewis6991/gitsigns.nvim")
	use("ellisonleao/glow.nvim")
	use("akinsho/toggleterm.nvim")
	use("kyazdani42/nvim-tree.lua")
	use("lewis6991/impatient.nvim")
	use("antoinemadec/FixCursorHold.nvim")
	use("goolord/alpha-nvim")

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
