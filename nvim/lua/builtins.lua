vim.o.termguicolors = true
vim.o.secure = true
vim.o.compatible = false
vim.cmd('filetype plugin indent on')
vim.o.visualbell = true
vim.o.showmode = false -- Do not display modes
vim.o.hidden = true
vim.o.lazyredraw = true
vim.o.showmatch = true
vim.o.updatetime = 100
vim.o.shortmess = vim.o.shortmess .. 'c' -- Omit the hit <Enter> messages
vim.o.mouse = 'a' -- Enable Cursor
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 100
vim.wo.number = true
vim.wo.relativenumber = false
vim.wo.signcolumn = 'auto'
vim.o.ruler = true
vim.o.cursorline = true

vim.bo.autoindent = true
vim.o.autoindent = true
vim.bo.smartindent = true
vim.o.smartindent = true

-- Tab
vim.o.tabstop = 4
vim.bo.tabstop = 4
vim.o.softtabstop = 4
vim.bo.softtabstop = 4
vim.o.shiftwidth = 4
vim.bo.shiftwidth = 4
vim.o.expandtab = true
vim.bo.expandtab = true
vim.o.shiftround = true

vim.wo.list = true
vim.o.listchars = 'tab:┆·,nbsp:⎵,trail:·,precedes:,extends:'
vim.o.scrolloff = 4

vim.wo.wrap = true

-- Fold
vim.wo.foldmethod = 'indent'
vim.o.foldlevelstart = 99 -- Unfold every block

vim.o.completeopt = 'menuone,noinsert,noselect'

vim.o.splitright = true
vim.o.splitbelow = true

-- Serach
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

---------------------------------------------------
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

function quit()
    local buffer_number = 0
    for buffer = 1, vim_fn.bufnr('$') do
        if vim_fn.bufexists(buffer) then
            buffer_number = buffer_number + 1
        end
    end
    if buffer_number == 1 then
        return ":q<cr>"
    end
    return ":bdelete<cr>"
end
-- Remap SPACE as <LEADER>
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
keymap('', ';', ':', opts) -- Colon shortcut
-- keymap('', 'Q', ':q<cr>', opts) -- Quit
keymap('', 'Q', '<cmd>lua require("utils").close_buffer()<cr>', opts) -- Quit
keymap('', 'S', ':w<cr>', opts) -- Save
keymap('', 'U', '<C-r>', opts) -- Redo
keymap('', 'R', ':source $MYVIMRC<cr>', opts) -- Reload vimrc
-- Fast Navigation
keymap('', 'J', '20j', opts)
keymap('', 'K', '20k', opts)
keymap('', 'H', '0', opts)
keymap('', 'L', '$', opts)
-- Search
keymap('', '<leader><cr>', ':nohlsearch<cr>', opts)
keymap('', '-', 'Nzz', opts) -- Previous
keymap('', '=', 'nzz', opts) -- Next
-- Switch Uppercase/lowercase
keymap('', '`', '~', opts)
-- Indentation
keymap('n', '<', '<<', opts)
keymap('n', '>', '>>', opts)
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)
-- Resize Split-windows with arrow keys
keymap('', '<up>', ':res +5<cr>', opts)
keymap('', '<down>', ':res -5<cr>', opts)
keymap('', '<left>', ':vertical resize-5<cr>', opts)
keymap('', '<right>', ':vertical resize+5<cr>', opts)
local opts = { noremap = true, silent = true }
-- Split Screen Cursor Naviation
keymap('', '<leader>h', '<c-w>h', opts)
keymap('', '<leader>j', '<c-w>j', opts)
keymap('', '<leader>k', '<c-w>k', opts)
keymap('', '<leader>l', '<c-w>l', opts)
-- Tab Switch
keymap('', '<leader>1', '1gt', opts)
keymap('', '<leader>2', '2gt', opts)
keymap('', '<leader>3', '3gt', opts)
keymap('', '<leader>4', '4gt', opts)
keymap('', '<leader>5', '5gt', opts)
keymap('', '<leader>6', '6gt', opts)
keymap('', '<leader>7', '7gt', opts)
keymap('', '<leader>8', '8gt', opts)
keymap('', '<leader>9', '9gt', opts)
keymap('', '<leader>0', ':tabo<cr>', opts)
-- Screen Layout
keymap('', '<leader><leader>h', '<c-w>H', opts) -- Horizontal
keymap('', '<leader><leader>j', '<c-w>J', opts) -- Vertical
-- Split Screen
keymap('', 's', '<nop>', {})
keymap('', 'sh', ':set splitright<cr>:vsplit<cr>', opts)
keymap('', 'sv', ':set splitbelow<cr>:split<cr>', opts)
keymap('', 'st', ':tabnew<cr>', opts)
