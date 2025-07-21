return { -- Essentials
"nvim-lua/plenary.nvim", "nvim-lua/popup.nvim", "BurntSushi/ripgrep", "kyazdani42/nvim-web-devicons", {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2"
}, -- treesitter
{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
}, -- LSP
{
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = { -- LSP Support
    {'neovim/nvim-lspconfig'}, {'williamboman/mason.nvim'}, {'williamboman/mason-lspconfig.nvim'}, -- Autocompletion
    {'hrsh7th/nvim-cmp'}, {'hrsh7th/cmp-nvim-lsp'}, {'hrsh7th/cmp-buffer'}, {'hrsh7th/cmp-path'},
    {'saadparwaiz1/cmp_luasnip'}, {'hrsh7th/cmp-nvim-lua'}, -- Snippets
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    }, {'rafamadriz/friendly-snippets'}}
},
-- colorscheme
"sainnhe/gruvbox-material",
-- other plugins
"windwp/nvim-autopairs", "JoosepAlviste/nvim-ts-context-commentstring", "NvChad/nvim-colorizer.lua",
"lewis6991/gitsigns.nvim", "folke/trouble.nvim", "nvim-lualine/lualine.nvim"}
