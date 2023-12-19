local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins   = {
    -- Essentials
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    "BurntSushi/ripgrep",
    "kyazdani42/nvim-web-devicons",
    { "nvim-telescope/telescope.nvim",   tag = "0.1.2" },
    -- treesitter
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    -- LSP
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            {
                "L3MON4D3/LuaSnip",
                -- follow latest release.
                version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
                -- install jsregexp (optional!).
                build = "make install_jsregexp"
            },
            { 'rafamadriz/friendly-snippets' },
        }
    },
    -- colorscheme
    "sainnhe/gruvbox-material",

    -- other plugins
    "windwp/nvim-autopairs",
    "numToStr/Comment.nvim",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "NvChad/nvim-colorizer.lua",
    "tpope/vim-fugitive",
    "phaazon/hop.nvim",
    "lewis6991/gitsigns.nvim",
    "folke/trouble.nvim",
    "nvim-lualine/lualine.nvim"

}

vim.g.mapleader = " "

local opts      = {}
require("lazy").setup(plugins, opts)
