--[[
 __  ____   __  _   ___     _____ __  __ ____   ____
|  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
| |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |
| |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___
|_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|

Author: @Soooda
--]]


---- Plugins ----
local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

vim.cmd [[packadd packer.nvim]]
vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost plugins.lua PackerCompile
  augroup end
]], false)

local use = require('packer').use
require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}
  use 'Mofiqul/dracula.nvim'
end)

---- Config ----
vim.o.termguicolors = true
vim.o.secure = true
vim.o.compatible = false
vim.cmd('filetype plugin indent on')
vim.o.visualbell = true
vim.o.showmode = false -- Do not display modes
vim.o.hidden = true
vim.o.lazyredraw = true
vim.o.showmatch = true
vim.o.updatetime = 1000
vim.o.shortmess = vim.o.shortmess .. 'c' -- Omit the hit <Enter> messages
vim.o.mouse = 'a' -- Enable Cursor
vim.o.timeoutlen = 2500
vim.o.ttimeoutlen = 100
vim.wo.number = true
vim.wo.relativenumber = false
vim.wo.signcolumn = 'number'
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

-- Restore cursor position
vim.cmd[[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]

---- Key Binds ----
local keymap = vim.api.nvim_set_keymap
-- Remap SPACE as <LEADER>
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent=true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
local opts = { noremap = true }
keymap('', ';', ':', opts) -- Colon shortcut
keymap('', 'Q', ':q<CR>', opts) -- Quit
keymap('', 'S', ':w<CR>', opts) -- Save
keymap('', 'U', '<C-r>', opts) -- Redo
keymap('', 'R', ':source $MYVIMRC<CR>', opts) -- Reload vimrc
-- Fast Navigation
keymap('', 'J', '20j', opts)
keymap('', 'K', '20k', opts)
keymap('', 'H', '0', opts)
keymap('', 'L', '$', opts)
-- Search
keymap('', '<LEADER><CR>', ':nohlsearch<CR>', opts)
keymap('', '-', 'Nzz', opts) -- Previous
keymap('', '=', 'nzz', opts) -- Next
-- Switch Uppercase/lowercase
keymap('', '`', '~', opts)
-- Indentation
keymap('', '<', '<<', opts)
keymap('', '>', '>>', opts)
-- Resize Split-windows with arrow keys
keymap('', '<UP>', ':res +5<CR>', opts)
keymap('', '<DOWN>', ':res -5<CR>', opts)
keymap('', '<LEFT>', ':vertical resize-5<CR>', opts)
keymap('', '<RIGHT>', ':vertical resize+5<CR>', opts)
local opts = { noremap = true, silent = true }
-- Split Screen Cursor Naviation
keymap('', '<LEADER>h', '<C-w>h', opts)
keymap('', '<LEADER>j', '<C-w>j', opts)
keymap('', '<LEADER>k', '<C-w>k', opts)
keymap('', '<LEADER>l', '<C-w>l', opts)
-- Tab Switch
keymap('', '<LEADER>1', '1gt', opts)
keymap('', '<LEADER>2', '2gt', opts)
keymap('', '<LEADER>3', '3gt', opts)
keymap('', '<LEADER>4', '4gt', opts)
keymap('', '<LEADER>5', '5gt', opts)
keymap('', '<LEADER>6', '6gt', opts)
keymap('', '<LEADER>7', '7gt', opts)
keymap('', '<LEADER>8', '8gt', opts)
keymap('', '<LEADER>9', '9gt', opts)
keymap('', '<LEADER>0', ':tabo<CR>', opts)
-- Screen Layout
keymap('', '<LEADER><LEADER>h', '<C-w>H', opts) -- Horizontal
keymap('', '<LEADER><LEADER>j', '<C-w>J', opts) -- Vertical
-- Split Screen
keymap('', 's', '<nop>', {})
keymap('', 'sh', ':set splitright<CR>:vsplit<CR>', opts)
keymap('', 'sv', ':set splitbelow<CR>:split<CR>', opts)
keymap('', 'st', ':tabnew<CR>', opts)


---- Pre-launch Commands ----
--vim.o.background = 'dark'
vim.g.colors_name = 'dracula'
vim.cmd('nohlsearch')
