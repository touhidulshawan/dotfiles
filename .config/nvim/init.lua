if vim.g.vscode then
    require("shawan")
    require("plugins.fugitive")
    require("plugins.hop")
    require("plugins.comment")
else
require("shawan")
require("plugins")
end
