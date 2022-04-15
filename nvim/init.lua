--[[
 __  ____   __  _   ___     _____ __  __ ____   ____
|  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
| |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |
| |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___
|_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|
Author: @Soooda
--]]

--vim.cmd('color catppuccin')
vim.cmd('color dracula')

require("plugin-config")
require("plugins")
require("builtins")
require("lsp")

-- Restore cursor position
vim.cmd[[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]

---- Pre-launch Commands ----
--vim.o.background = 'dark'
vim.cmd('nohlsearch')
