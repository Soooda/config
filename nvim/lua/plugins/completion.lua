return {
	-- Auto-pairing brackets
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			disable_filetype = { "TelescopePrompt", "vim" },
			check_ts = true,
			enable_check_bracket_line = true,
			fast_wrap = {
				chars = { "{", "(", "[", "<", '"', "'", "`" },
			},
		},
		config = function(_, opts)
			local autopairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")
			local cond = require("nvim-autopairs.conds")
			autopairs.setup(opts)
			autopairs.add_rules({
				Rule("<", ">"):with_pair(cond.before_regex("%a+")):with_move(function(o) return o.char == ">" end),
			})
		end,
	},
	-- Completion + snippets
	{
		"saghen/blink.cmp",
		version = "1.*",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"rafamadriz/friendly-snippets",
			{
				"fang2hou/blink-copilot",
				opts = {},
			},
		},
		opts = {
			keymap = {
				preset = "default",
				["<Tab>"] = { "show", "select_next", "fallback" },
				["<S-Tab>"] = { "show", "select_prev", "fallback" },
				["<CR>"] = { "accept", "fallback" },
			},
			snippets = {
				expand = function(snippet) vim.snippet.expand(snippet) end,
				active = function(filter) return vim.snippet.active(filter) end,
				jump = function(direction) vim.snippet.jump(direction) end,
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "copilot" },
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-copilot",
						enabled = false,
						async = true,
						score_offset = 100,
					},
				},
			},
			cmdline = {
				enabled = true,
				keymap = { preset = "inherit" },
				completion = {
					menu = { auto_show = true },
				},
				sources = function()
					local cmdtype = vim.fn.getcmdtype()
					if cmdtype == "/" or cmdtype == "?" then
						return { "buffer" }
					end
					if cmdtype == ":" or cmdtype == "@" then
						return { "cmdline", "buffer" }
					end
					return {}
				end,
			},
		},
		opts_extend = { "sources.default" },
	},
	-- Copilot (kept disabled, ready for blink-copilot bridge)
	{
		"zbirenbaum/copilot.lua",
		enabled = false,
		build = ":Copilot auth",
		cmd = "Copilot",
		event = { "InsertEnter", "CmdlineEnter" },
		opts = {
			panel = { enabled = false },
			suggestion = {
				enabled = false,
				auto_trigger = false,
			},
			filetypes = {
				yaml = true,
				markdown = true,
				gitcommit = true,
				gitrebase = true,
				hgcommit = true,
				svn = true,
				["."] = true,
			},
		},
	},
	-- Switch between single-line and multiline forms of code
	{
		"Wansmer/treesj",
		keys = {
			{ "<leader>s", ":TSJToggle<CR>", silent = true, desc = "Single-line/Multiline forms" },
		},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			use_default_keymaps = false,
			max_join_length = 999,
		},
	},
	-- Sorting plugin that supports line-wise and delimiter sorting
	{
		"sQVe/sort.nvim",
		keys = {
			{ "go", ":Sort<CR>", mode = "n", silent = true, desc = "Sort Line" },
			{ "go", "<Esc>:Sort<CR>", mode = "v", silent = true, desc = "Sort" },
			{ "gO", ":Sort!<CR>", mode = "n", silent = true, desc = "Reverse Sort Line" },
			{ "gO", "<Esc>:Sort!<CR>", mode = "v", silent = true, desc = "Reverse Sort" },
		},
	},
	-- Surround Plugin
	{
		"kylechui/nvim-surround",
		event = { "BufReadPost", "BufNewFile" },
		config = true,
	},
	-- Commenting
	{
		"echasnovski/mini.comment",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		keys = {
			{ "<leader>c", nil, mode = { "n", "o", "x" }, desc = "Toggle Comment" },
		},
		opts = {
			options = {
				ignore_blank_line = true,
			},
			mappings = {
				comment = "<leader>c",
				comment_line = "<leader>c",
				comment_visual = "<leader>c",
				textobject = "<leader>c",
			},
			hooks = {
				pre = function() require("ts_context_commentstring.internal").update_commentstring({}) end,
			},
		},
	},
}
