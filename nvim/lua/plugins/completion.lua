local icons = {
	Keyword = "󰌋 ",
	Operator = "󰆕 ",

	Text = " ",
	Value = "󰎠 ",
	Constant = "󰏿 ",

	Method = " ",
	Function = "󰊕 ",
	Constructor = " ",

	Class = " ",
	Interface = " ",
	Module = " ",

	Variable = " ",
	Property = "󰜢 ",
	Field = "󰜢 ",

	Struct = "󰙅 ",
	Enum = " ",
	EnumMember = " ",

	Snippet = " ",

	File = " ",
	Folder = " ",

	Reference = "󰈇 ",
	Event = " ",
	Color = " ",
	Unit = "󰑭 ",
	TypeParameter = " ",
}

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
				-- map = "<M-e>",
				chars = { "{", "(", "[", "<", '"', "'", "`" },
			},
		},
		-- TODO: remove this block when https://github.com/windwp/nvim-autopairs/pull/363 is merged
		config = function(opts)
			local autopairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")
			local cond = require("nvim-autopairs.conds")
			autopairs.setup(opts)
			autopairs.add_rules {
				Rule("<", ">"):with_pair(cond.before_regex("%a+")):with_move(function(o) return o.char == ">" end),
			}
		end,
		-- END TODO
	},
	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				vim.schedule(function() require("luasnip.loaders.from_vscode").lazy_load() end)
			end,
		},
		lazy = true,
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
	},
	-- Auto Completion
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp", lazy = true },
			{ "hrsh7th/cmp-buffer", lazy = true },
			{ "hrsh7th/cmp-cmdline", lazy = true },
			{ "hrsh7th/cmp-path", lazy = true },

			-- For luasnip users
			{ "saadparwaiz1/cmp_luasnip", lazy = true },
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup {
				preselect = cmp.PreselectMode.None,
				mapping = {
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-u>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
					["<C-e>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
					["<M-u>"] = cmp.mapping.scroll_docs(-4),
					["<M-e>"] = cmp.mapping.scroll_docs(4),
					["<CR>"] = cmp.mapping.confirm { select = true },
					["<S-CR>"] = cmp.mapping.confirm { select = true, behavior = cmp.ConfirmBehavior.Replace },
				},
				snippet = {
					expand = function(args) require("luasnip").lsp_expand(args.body) end,
				},
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer" },
					{ name = "luasnip" },
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, item)
						item.kind = icons[item.kind] or item.kind

						local truncated = vim.fn.strcharpart(item.abbr, 0, 30)
						if truncated ~= item.abbr then
							item.abbr = truncated .. "…"
						end

						return item
					end,
				},
			}

			local mapping = {
				["<Tab>"] = cmp.mapping(function()
					if cmp.visible() then
						cmp.select_next_item()
					else
						cmp.complete()
					end
				end, { "c" }),
				["<S-Tab>"] = cmp.mapping(function()
					if cmp.visible() then
						cmp.select_prev_item()
					else
						cmp.complete()
					end
				end, { "c" }),
			}

			-- Use buffer source for `/` and `?`
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = mapping,
				completion = {
					completeopt = "menu,menuone,noselect",
				},
				sources = {
					{ name = "buffer", keyword_length = 2 },
				},
			})

			-- Use cmdline & path source for ':'
			cmp.setup.cmdline(":", {
				mapping = mapping,
				completion = {
					completeopt = "menu,menuone,noselect",
				},
				sources = cmp.config.sources({
					{ name = "path", keyword_length = 2 },
				}, {
					{ name = "cmdline", keyword_length = 2 },
				}),
			})
		end,
	},
	-- Copilot
	{
		"zbirenbaum/copilot.lua",
		enabled = false,
		build = ":Copilot auth",
		cmd = "Copilot",
		event = { "InsertEnter", "CmdlineEnter" },
		opts = {
			panel = { enabled = false },
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept = false,
					prev = "<M-[>",
					next = "<M-]>",
					dismiss = false,
				},
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
		config = function(_, opts)
			require("copilot").setup(opts)

			vim.keymap.set("i", "<Tab>", function()
				if require("copilot.suggestion").is_visible() then
					require("copilot.suggestion").accept()
				else
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
				end
			end, { silent = true })
		end,
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
			{ "go", ":Sort<CR>", mode = "n", silent = true, desc = "Sort Line"
			},
			{ "go", "<Esc>:Sort<CR>", mode = "v", silent = true, desc = "Sort" },
			{ "gO", ":Sort!<CR>", mode = "n", silent = true, desc = "Reverse Sort Line"
			},
			{ "gO", "<Esc>:Sort!<CR>", mode = "v", silent = true, desc = "Reverse Sort" },
		},
	},
	-- Surround Plugin
	{
		"kylechui/nvim-surround",
		-- TODO: Add Which-key descriptions
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
				pre = function() require("ts_context_commentstring.internal").update_commentstring {} end,
			},
		},
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
				pre = function() require("ts_context_commentstring.internal").update_commentstring {} end,
			},
		},
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
				pre = function() require("ts_context_commentstring.internal").update_commentstring {} end,
			},
		},
	},
}
