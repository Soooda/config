--[[
 __  ____   __  _   ___     _____ __  __ ____   ____
|  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
| |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |
| |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___
|_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|

Author: @Soooda
--]]

-- =========================Bootstrap Lazy.nvim=================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", --A latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)


-- ==============================Setting Options================================
vim.o.visualbell = true -- Visual Bell
vim.o.hlsearch = true   -- Set highlight on search
vim.cmd("nohlsearch")   -- Disable Highlight Search on launch

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.wo.number = true -- Make line numbers default

-- Display the active line and Only highlight the active line number
vim.o.cursorline = true
vim.o.cursorlineopt = "number"

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Decrease update time
vim.o.updatetime = 250

-- Display the sign column only when there are signs to display
vim.wo.signcolumn = "auto"

-- Set colorscheme
vim.o.termguicolors = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 4

-- Default split screens to the right and below
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.tabstop = 4 -- Set Tab Stop
vim.o.shiftwidth = 4

-- Set using the system clipboard
-- vim.go.clipboard = "unnamedplus"

-- Restore cursor position
vim.cmd [[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]

--[[
-- ==============================Basic Keymaps=================================
--]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<NOP>', { silent = true })

-- The default j and k motions move across physical lines, not the visible, soft-wrapped screen lines
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Colon Shortcut by simply pressing the semicolon
vim.keymap.set('n', ';', ':', { silent = true, desc = "Input Command (just like :)" })

-- Press shift + q to quit
vim.keymap.set('n', 'Q', ':q<CR>', { silent = true, desc = "Quit" })

-- Press shift + s to save
vim.keymap.set('n', 'S', ':w<CR>', { silent = true, desc = "Save" })

-- Press shift + u to redo
vim.keymap.set('n', 'U', '<C-r>', { silent = true, desc = "Redo" })

-- Press shift + h/l to go to the first/last char of the line
vim.keymap.set({ 'n', 'v' }, 'H', '0', { silent = true, desc = "Go to the first character" })
vim.keymap.set({ 'n', 'v' }, 'L', '$', { silent = true, desc = "Go to the last character" })

-- Press leader + enter to stop search (no highlight search)
vim.keymap.set({ 'n', 'v' }, '<LEADER><CR>', ':nohlsearch<CR>',
	{ silent = true, desc = "Turn off the search highlights" })

-- Press -/= to go to the previous/next found item and center
vim.keymap.set({ 'n', 'v' }, '-', 'Nzz', { silent = true, desc = "Go to the previous found item" })
vim.keymap.set({ 'n', 'v' }, '=', 'nzz', { silent = true, desc = "Go to the next found item" })

-- Press ` to switch case of the selected character
vim.keymap.set({ 'n', 'v' }, '`', '~', { silent = true, desc = "Switch Case" })

-- Press </> to indent left/right
vim.keymap.set('n', '<', '<<', { silent = true, desc = "Indent one level" })
vim.keymap.set('n', '>', '>>', { silent = true, desc = "Un-indent one level" })
vim.keymap.set('v', '<', '<gv', { silent = true, desc = "Indent one level" })
vim.keymap.set('v', '>', '>gv', { silent = true, desc = "Un-indent one level" })

-- Press arrow keys to resize sub-screens
vim.keymap.set('n', '<UP>', ':res +5<CR>', { silent = true, desc = "Decrease window height" })
vim.keymap.set('n', '<DOWN>', ':res -5<CR>', { silent = true, desc = "Increase window height" })
vim.keymap.set('n', '<LEFT>', ':vertical resize-5<CR>', { silent = true, desc = "Decrease window width" })
vim.keymap.set('n', '<RIGHT>', ':vertical resize+5<CR>', { silent = true, desc = "Increase window width" })

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
vim.keymap.set('', 's', '<NOP>', {}) -- Reassign s key to no action
vim.keymap.set('n', 'sh', ':set splitright<cr>:vsplit<CR>', { silent = true, desc = "[S]pawn a screen [H]orizontally" })
vim.keymap.set('n', 'sv', ':set splitbelow<cr>:split<CR>', { silent = true, desc = "[S]pawn a screen [V]ertically" })

-- Press s + t to spawn a new tab
vim.keymap.set('n', 'st', ':tabnew<CR>', { silent = true, desc = "[S]pawn a new [T]ab" })

-- Press <LEADER> + y to yank to the system clipboard
vim.keymap.set({ 'n', 'v' }, '<LEADER>y', '"+y', { silent = true, desc = "[Y]ank to the system clipboard" })
vim.keymap.set('n', '<LEADER>Y', '"+yg_', { silent = true, desc = "[Y]ank line without \n" })
vim.keymap.set('n', '<LEADER>yy', '"+yy', { silent = true, desc = "[Y]ank line with \n" })

-- Press <LEADER> + p to paste from the system clipboard
vim.keymap.set({ 'n', 'v' }, '<LEADER>p', '"+p', { silent = true, desc = "[P]aste after from the system clipboard" })
vim.keymap.set({ 'n', 'v' }, '<LEADER>P', '"+P', { silent = true, desc = "[P]aste before from the system clipboard" })

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})


-- ==============================Plugin Configs=================================
-- [[ lazy.nvim ]]
require("lazy").setup({
	-- My Favourite Theme
	{
		"Mofiqul/dracula.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme dracula]])
		end,
	},
	-- Display cursor line
	{
		"yamatsum/nvim-cursorline",
		lazy = false,
		opts = {
			cursorline = {
				enable = true,
				timeout = 1000,
				number = false,
			},
			cursorword = {
				enable = true,
				min_length = 3,
				hl = { underline = true },
			}
		},
	},
	-- Scroll Bar
	{
		"dstein64/nvim-scrollview",
		lazy = true,
		event = "VeryLazy",
		opts = {
			excluded_filetypes = {'neo-tree'},
			current_only = true,
			base = 'right',
			column = 1,
			winblend = 50,
			winblend_gui = 50,
			signs_on_startup = {'all'},
			diagnostics_severities = {vim.diagnostic.severity.ERROR},
		},
	},
	-- Icons
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		event = "VeryLazy",
		opts = {
			-- your personnal icons can go here (to override)
			-- you can specify color or cterm_color instead of specifying both of them
			-- DevIcon will be appended to `name`
			override = {},
			-- globally enable different highlight colors per icon (default to true)
			-- if set to false all icons will have the default icon's color
			color_icons = true,
			-- globally enable default icons (default to false)
			-- will get overriden by `get_icons` option
			default = true,
		},
	},
	-- Add indentation guides even on blank lines
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		lazy = true,
		event = "VeryLazy",
		opts = {
			indent = {
				char = '┊',
				smart_indent_cap = true,
			},
			whitespace = {
				remove_blankline_trail = true,
			},
			scope = {
				enabled = true,
			},
		},
	},
	-- Auto enclose brackets
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true,
		},
	},
	-- "gc" to comment visual regions/lines
	{
		"numToStr/Comment.nvim",
		lazy = false,
		opts = {
		},
	},
	-- Display git symbols for changes
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = "VeryLazy",
		opts = {
			signs = {
				add          = { text = '▎' },
				change       = { text = '░' },
				delete       = { text = '▏' },
				topdelete    = { text = '▔' },
				changedelete = { text = '▒' },
				untracked    = { text = '+' },
			},
		},
	},
	-- Highlight, edit and navigate code
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"vim",
					"vimdoc",
					"query",
					"csv",
					"bash",
					"c",
					"cmake",
					"c_sharp",
					"cpp",
					"lua",
					"python",
					"java",
					"javascript",
					"go",
					"matlab",
					"json",
					"html",
					"css",
					"scss",
					"swift",
					"vue",
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	-- Improve J, K scrolling speed
	{
		"rainbowhxch/accelerated-jk.nvim",
		lazy = true,
		event = "VeryLazy",
		opts = {
			mode = 'time_driven',
			enable_deceleration = false,
			acceleration_motions = {},
			acceleration_limit = 150,
			acceleration_table = { 3, 6, 9, 12, 15, 18, 23, 28, 30 },
			-- when 'enable_deceleration = true', 'deceleration_table = { {200, 3}, {300, 7}, {450, 11}, {600, 15}, {750, 21}, {900, 9999} }'
			deceleration_table = { { 150, 9999 } }
		},
		config = function()
			vim.keymap.set('n', 'j', '<Plug>(accelerated_jk_gj)', {})
			vim.keymap.set('n', 'k', '<Plug>(accelerated_jk_gk)', {})
		end,
	},
	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		lazy = true,
		event = "VeryLazy",
		opts = {
			options = {
				icons_enabled = true,
				theme = 'dracula-nvim',
				component_separators = '│',
				section_separators = ' ',
				disabled_filetypes = {
					statusline = { 'NvimTree' },
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				}
			},
			sections = {
				lualine_a = { 'mode' },
				lualine_b = { "string.format('R:%3d C:%-2d', vim.fn.line('.'), vim.fn.virtcol('.'))" },
				lualine_c = { 'filename' },
				lualine_x = {},
				lualine_y = { 'diagnostics', 'diff', 'branch' },
				lualine_z = { 'filesize' }
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { 'filename' },
				lualine_x = { "string.format('R:%3d C:%-2d', vim.fn.line('.'), vim.fn.virtcol('.'))" },
				lualine_y = {},
				lualine_z = {}
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {}
		},
	},
	-- Colorizer
	{
		"norcalli/nvim-colorizer.lua",
		lazy = true,
		ft = {
			"css",
			"html",
		},
		opts = {
			"*",
			css = {
				css = true,
			},
		},
	},
	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	-- File Inspector
	{
		"nvim-neo-tree/neo-tree.nvim",
		keys = {
			{ "<F1>", "<cmd>Neotree toggle<cr>", desc = "Toggle Neotree" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		lazy = true,
		event = "VeryLazy",
		opts = {
			window = {
				width = 25,
			},
		},
	},
	-- Auto Modification for HTML-like tags
	{
		"AndrewRadev/tagalong.vim",
		lazy = true,
		ft = {
			"html",
			"xml",
		},
		config = function()

		end,
	},
	-- ToggleAlternate
	{
		"rmagatti/alternate-toggler",
		lazy = true,
		event = "BufReadPost",
		keys = {
			{ "<leader>`", "<cmd>lua require('alternate-toggler').toggleAlternate()<CR>", desc = "Toggle Alternate" },
		},
		opts = {
			alternates = {
				["=="] = "!=",
			},
		},
	},
	-- Toggle Terminal
	{
		"akinsho/toggleterm.nvim",
		lazy = true,
		event = "VeryLazy",
		opts = {
			open_mapping = '<F2>',
			direction = 'float',
			shade_terminals = true,
		},
	},
	-- Open files in nvim from embedded terminal
	-- {
	--	"willothy/flatten.nvim",
	--	lazy = false,
	--	priority = 1001,
	-- },
	-- Key Mappings Hint
	{
		"folke/which-key.nvim",
		lazy = true,
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			win = {
				border = "rounded",
				margin = { 0.7, 0, 1, 0.6 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
				padding = { 0, 0, 0, 0 }, -- extra window padding [top, right, bottom, left]
			},
			layout = {
				height = { min = 4, max = 15 }, -- min and max height of the columns
				width = { min = 20, max = 50 }, -- min and max width of the columns
				spacing = 0,
				align = "left",
			},
		},
	},
	-- Auto Resize Window
	-- {
	--	"anuvyklack/windows.nvim",
	--	event = "WinNew",
	--	dependencies = {
	--		{ "anuvyklack/middleclass" },
	--		{ "anuvyklack/animation.nvim", enabled = false },
	--	},
	--	keys = { { "<leader>m", "<cmd>WindowsMaximize<cr>", desc = "Zoom" } },
	--	config = function()
	--		vim.o.winwidth = 5
	--		vim.o.equalalways = false
	--		require("windows").setup({
	--		animation = { enable = false, duration = 150 },
	--		})
	--	end,
	-- },
	-- LSPs
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"j-hui/fidget.nvim",
			"folke/neodev.nvim", -- Additional lua configuration, makes nvim stuff amazing
		},
		config = function()
			--  This function gets run when an LSP connects to a particular buffer.
			local on_attach = function(_, bufnr)
				-- In this case, we create a function that lets us more easily define mappings specific
				-- for LSP related items. It sets the mode, buffer and description for us each time.
				local nmap = function(keys, func, desc)
					if desc then
						desc = 'LSP: ' .. desc
					end

					vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
				end

				nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
				nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

				nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
				-- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
				nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
				nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
				-- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
				-- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

				-- See `:help K` for why this keymap
				nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
				nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

				-- Lesser used LSP functionality
				nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
				nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
				nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
				nmap('<leader>wl', function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, '[W]orkspace [L]ist Folders')

				-- Create a command `:Format` local to the LSP buffer
				vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
					vim.lsp.buf.format()
				end, { desc = 'Format current buffer with LSP' })
			end

			-- Setup neovim lua configuration
			require("neodev").setup()
			-- Setup mason so it can manage external tooling
			require("mason").setup {
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				}
			}
			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. They will be passed to
			--  the `settings` field of the server config. You must look up that documentation yourself.
			local servers = {
				-- clangd = {},
				-- gopls = {},
				-- rust_analyzer = {},
				-- tsserver = {},

				lua_ls = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
				pyright = {
					pyright = {
						autoImportCompletion = true,
					},
					python = {
						analysis = {
							autoSearchPaths = true,
							diagnosticMode = 'openFilesOnly',
							useLibraryCodeForTypes = true,
							typeCheckingMode = 'off',
						}
					},
				},
				jdtls = {},
				tsserver = {},
				clangd = {},
			}
			-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
			-- Ensure the servers above are installed
			local mason_lspconfig = require 'mason-lspconfig'
			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(servers),
			})
			mason_lspconfig.setup_handlers {
				function(server_name)
					require('lspconfig')[server_name].setup {
						capabilities = capabilities,
						on_attach = on_attach,
						settings = servers[server_name],
					}
				end,
			}
			-- Turn on lsp status information
			require("fidget").setup()
		end,
	},
	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		-- load cmp on InsertEnter
		event = "InsertEnter",
		-- These dependencies will only be loaded when cmp loads
		-- Dependencies are always lazy-loaded unless specified otherwise
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			cmp.setup({
				window = {
					completion = {
						-- rounded border; thin-style scrollbar
						border = 'single',
						scrollbar = '║',
					},
					documentation = {
						-- no border; native-style scrollbar
						border = 'rounded',
						scrollbar = '',
					},
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<CR>'] = cmp.mapping.confirm({
						select = true, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
						behavior = cmp.ConfirmBehavior.Replace,
					}),
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { 'i', 's' }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{
						name = "buffer",
						option = {},
					},
				},
			})
			-- Diagnostic keymaps
			vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to the previous diagnosis" })
			vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to the next diagnosis" })
			vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float,
				{ desc = "Show diagnostics in a floating window" })
			vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Go to the previous diagnosis" })
		end,
	},
	-- Squeeze and unsqueeze json-like list
	{
		'Wansmer/treesj',
		lazy = true,
		event = "VeryLazy",
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		opts = {
			use_default_keymaps = false,
		},
		config = function ()
			vim.keymap.set('n', '<leader>m', require('treesj').toggle, { desc = "Toggle squeezing json-like structure" })
		end,
	},
	-- Buffer line
	{
		'akinsho/bufferline.nvim',
		version = "*",
		lazy = true,
		event = "VeryLazy",
		dependencies = 'nvim-tree/nvim-web-devicons',
		opts = {
			options = {
				mode = "tabs",
				numbers = "none",
				indicator = {
					icon = " * ",
					style = "icon",
				},
				diagnostics = "nvim_lsp",
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						text_align = "center",
						separator = true,
					},
				},
				show_close_icon = false,
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
				separator_style = "thin",
			},
		},
	}
}, {
	-- lazy.nvim settings
	ui = {
		border = "rounded",
	},
})
-- ===================================End=======================================
