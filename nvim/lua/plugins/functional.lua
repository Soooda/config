return {
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
	-- Edit Directories like a File
	{
		"stevearc/oil.nvim",
		opts = {
			delete_to_trash = false,
		},
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
		config = function()
			require('oil').setup()
		end
	},
}
