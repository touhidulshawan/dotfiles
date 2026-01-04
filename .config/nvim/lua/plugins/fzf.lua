return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
        { "<leader>ff", function() require("fzf-lua").files() end, desc = "Find files in current directory" },
        { "<leader>o", function() require("fzf-lua").oldfiles() end, desc = "Show old files" },
    }
}
