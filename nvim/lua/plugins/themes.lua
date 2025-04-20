return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        enabled = true,
        lazy = false,
        priority = 1000,
        opts = {
            flavour = "macchiato",
            background = {
                light = "latte",
                dark = "macchiato",
            },
            transparent_background = true,
            term_colors = true,
            integrations = {
                -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin")
        end
    },
	{
		"Mofiqul/dracula.nvim",
		enabled = false,
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd.colorscheme("dracula")
		end,
	},
	{
		"xero/evangelion.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("evangelion")
		end,
	}
}
