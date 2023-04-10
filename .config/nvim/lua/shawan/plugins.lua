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
	use({
		"nvim-treesitter/nvim-treesitter",
		 run = ":TSUpdate",
	})
	use("nvim-telescope/telescope.nvim")

	-- LSP
	use {
	    'VonHeikemen/lsp-zero.nvim',
	    branch = 'v1.x',
	    requires = {
		-- LSP Support
		{'neovim/nvim-lspconfig'},             -- Required
		{'williamboman/mason.nvim'},           -- Optional
		{'williamboman/mason-lspconfig.nvim'}, -- Optional

		-- Autocompletion
		{'hrsh7th/nvim-cmp'},         -- Required
		{'hrsh7th/cmp-nvim-lsp'},     -- Required
		{'hrsh7th/cmp-buffer'},       -- Optional
		{'hrsh7th/cmp-path'},         -- Optional
		{'saadparwaiz1/cmp_luasnip'}, -- Optional
		{'hrsh7th/cmp-nvim-lua'},     -- Optional

		-- Snippets
		{'L3MON4D3/LuaSnip'},             -- Required
		{'rafamadriz/friendly-snippets'}, -- Optional
	    }
	}

	-- code formatter 
	use ("mhartington/formatter.nvim")
	-- colorscheme
	use("gruvbox-community/gruvbox")

	-- other plugins
	use("windwp/nvim-autopairs")
	use("numToStr/Comment.nvim")
        use("JoosepAlviste/nvim-ts-context-commentstring")
	use("norcalli/nvim-colorizer.lua")
	use("tpope/vim-fugitive")
	use("phaazon/hop.nvim")
	use("lewis6991/gitsigns.nvim")
	use("folke/trouble.nvim")
	use {
	    'nvim-lualine/lualine.nvim',
	    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}



	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
