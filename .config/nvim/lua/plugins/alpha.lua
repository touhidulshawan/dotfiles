return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    local logo = [[ 
                                   __                
	    ___     ___    ___   __  __ /\_\    ___ ___ 
	   / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\
	  /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \
	  \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\
	   \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/
  ]]

    local function footer()
      return "TOUHIDUL SHAWAN"
    end

    opts.section.header.val = vim.split(logo, "\n", { trimempty = true })
    opts.section.buttons.val = {
      opts.button("f", "  Find file", ":Telescope find_files <CR>"),
      opts.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
      opts.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
      opts.button("g", "  Find text", ":Telescope live_grep <CR>"),
      opts.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
      opts.button("q", "  Quit Neovim", ":qa<CR>"),
    }
    opts.section.footer.val = footer()
  end,
}
