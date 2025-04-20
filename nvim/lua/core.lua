-- Set to true if a Nerd Font is installed and selected in the terminal
vim.g.have_nerd_font = true

-- Editing
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.visualbell = true
vim.opt.linebreak = true
vim.opt.showbreak = "↳"
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5 -- Only when nowrap is active
vim.opt.virtualedit = "block"

-- Enable mouse for all modes
vim.opt.mouse = 'a'

-- UI
vim.opt.winblend = 0 -- Floating window's opacity
vim.opt.pumblend = 0 -- Pop-up window's opacity
vim.opt.pumheight = 15 -- Height of pop-up window
vim.opt.showmode = false -- Display current mode
vim.opt.showcmd = true -- Display command
vim.opt.cmdheight = 1
vim.opt.laststatus = 3 -- Only one status line for all windows
vim.opt.ruler = false -- Show Row, Col
vim.opt.signcolumn = "auto"
vim.opt.shortmess = "atToOCFI"

-- Indent
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.breakindent = true -- Lines wrapped will still be indented

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.infercase = true
vim.opt.hlsearch = true
vim.cmd("nohlsearch") -- Turn off hlsearch on launch

-- Folding
vim.opt.foldlevel = 99
vim.opt.foldmethod = "expr"

-- Rendering
vim.opt.termguicolors = true

-- Default split screens to the right and below
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = false
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
-- vim.opt.listchars = { tab = '┆ ', trail = '·', nbsp = '␣' }
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }

-- Set Neovim to use the system clipboard for all yank, delete, change, and put operations
--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Cache/Log File
-- vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("$HOME/.cache/nvim/undo")
vim.opt.backupdir = vim.fn.expand("$HOME/.cache/nvim/backup")
vim.opt.viewdir = vim.fn.expand("$HOME/.cache/nvim/view")
vim.lsp.set_log_level("off") -- Disable lsp.log

-- Diagnostic
vim.opt.updatetime = 250
vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float()]])
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })
vim.diagnostic.config {
	virtual_text = false,
	float = { header = "", prefix = "", focusable = false },
	update_in_insert = true,
	severity_sort = true,
}

-- Misc.
vim.opt.history = 1000
vim.opt.wildignorecase = true
vim.opt.timeoutlen = 300
vim.opt.completeopt = "menuone,noselect"

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-- Restore cursor position when opening a file
-- https://github.com/neovim/neovim/issues/16339#issuecomment-1457394370
vim.api.nvim_create_autocmd("BufRead", {
	callback = function(opts)
		vim.api.nvim_create_autocmd("BufWinEnter", {
			once = true,
			buffer = opts.buf,
			callback = function()
				local ft = vim.bo[opts.buf].filetype
				local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
				if
					not (ft:match("commit") and ft:match("rebase"))
					and last_known_line > 1
					and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
				then
					vim.api.nvim_feedkeys('g`"', "nx", false)
				end
			end,
		})
	end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
