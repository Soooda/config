-- Leader Key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set("", "<Space>", "<Nop>")

-- Special Keys
vim.keymap.set({ "n", "v" }, ";", ":")
vim.keymap.set("", "<Tab>", "<Nop>") -- Will be handled in `plugins/completion.lua`
vim.keymap.set("", "s", "<Nop>")
-- Disable built-in comment action and resolve the which-key checkhealth issue
vim.keymap.del('n', 'gc')
vim.keymap.del('n', 'gcc')

-- Quit
vim.keymap.set('n', 'Q', ':q<CR>', { silent = true, desc = "Quit" })

-- Save
vim.keymap.set('n', 'S', ':w<CR>', { silent = true, desc = "Save" })

-- Redo
vim.keymap.set('n', 'U', '<C-r>', { silent = true, desc = "Redo" })

-- Press shift + h/l to go to the first/last char of the line
vim.keymap.set({ 'n', 'x' }, 'H', '0', { silent = true, desc = "Go to the first character" })
vim.keymap.set({ 'n', 'x' }, 'L', '$', { silent = true, desc = "Go to the last character" })

-- Press leader + enter to stop search (no highlight search)
vim.keymap.set('n', '<LEADER><CR>', ':nohlsearch<CR>', { silent = true, desc = "Turn off the search highlights" })
-- Press -/= to go to the previous/next found item and center
vim.keymap.set({ 'n', 'x' }, '-', 'Nzz', { silent = true, desc = "Go to the previous found item" })
vim.keymap.set({ 'n', 'x' }, '=', 'nzz', { silent = true, desc = "Go to the next found item" })

-- Press ` to switch case of the selected character
vim.keymap.set('n', '`', '~', { silent = true, desc = "Switch Case" })

-- Press </> to indent left/right
vim.keymap.set('n', '<', '<<', { silent = true, desc = "Indent one level" })
vim.keymap.set('n', '>', '>>', { silent = true, desc = "Un-indent one level" })
vim.keymap.set('x', '<', '<gv', { silent = true, desc = "Indent one level" })
vim.keymap.set('x', '>', '>gv', { silent = true, desc = "Un-indent one level" })

-- Press arrow keys to resize sub-screens
vim.keymap.set({'n', 'x'}, '<UP>', ':res +5<CR>', { silent = true, desc = "Decrease window height" })
vim.keymap.set({'n', 'x'}, '<DOWN>', ':res -5<CR>', { silent = true, desc = "Increase window height" })
vim.keymap.set({'n', 'x'}, '<LEFT>', ':vertical resize-5<CR>', { silent = true, desc = "Decrease window width" })
vim.keymap.set({'n', 'x'}, '<RIGHT>', ':vertical resize+5<CR>', { silent = true, desc = "Increase window width" })

-- Press leader + h/j/k/l to move the cursor around sub-screens
vim.keymap.set('n', '<LEADER>h', '<C-w>h', { silent = true, desc = "Go to the left screen" })
vim.keymap.set('n', '<LEADER>j', '<C-w>j', { silent = true, desc = "Go to the lower screen" })
vim.keymap.set('n', '<LEADER>k', '<C-w>k', { silent = true, desc = "Go to the upper screen" })
vim.keymap.set('n', '<LEADER>l', '<C-w>l', { silent = true, desc = "Go to the right screen" })

-- Press leader + 1-9 to switch tabs
vim.keymap.set('n', '<LEADER>1', '1gt', { silent = true, desc = "Go to Tab 1" })
vim.keymap.set('n', '<LEADER>2', '2gt', { silent = true, desc = "Go to Tab 2" })
vim.keymap.set('n', '<LEADER>3', '3gt', { silent = true, desc = "Go to Tab 3" })
vim.keymap.set('n', '<LEADER>4', '4gt', { silent = true, desc = "Go to Tab 4" })
vim.keymap.set('n', '<LEADER>5', '5gt', { silent = true, desc = "Go to Tab 5" })
vim.keymap.set('n', '<LEADER>6', '6gt', { silent = true, desc = "Go to Tab 6" })
vim.keymap.set('n', '<LEADER>7', '7gt', { silent = true, desc = "Go to Tab 7" })
vim.keymap.set('n', '<LEADER>8', '8gt', { silent = true, desc = "Go to Tab 8" })
vim.keymap.set('n', '<LEADER>9', '9gt', { silent = true, desc = "Go to Tab 9" })

-- Press leader + 0 to close all the other tabs
vim.keymap.set('n', '<LEADER>0', ':tabo<CR>', { silent = true, desc = "Close any other tabs" })

-- Press leader + leader + h/j to change the sub-screen layout to horizontal/vertical
vim.keymap.set('n', '<LEADER><LEADER>h', '<C-w>H', { silent = true, desc = "Sub-screen layout -> horizontal" })
vim.keymap.set('n', '<LEADER><LEADER>j', '<C-w>J', { silent = true, desc = "Sub-screen layout -> vertical" })

-- Press s + h/v to split a sub-screen horizontally/vertically
vim.keymap.set('n', 'sh', ':set splitright<cr>:vsplit<CR>', { silent = true, desc = "[S]pawn a screen [H]orizontally" })
vim.keymap.set('n', 'sv', ':set splitbelow<cr>:split<CR>', { silent = true, desc = "[S]pawn a screen [V]ertically" })

-- Press s + t to spawn a new tab
vim.keymap.set('n', 'st', ':tabnew<CR>', { silent = true, desc = "[S]pawn a new [T]ab" })
