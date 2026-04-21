return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			if has_cmp then
				capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
			end

			require("mason-lspconfig").setup({
				ensure_installed = { "pyright", "lua_ls" },
				automatic_installation = true,
			})

			vim.lsp.config("pyright", {
				capabilities = capabilities,
			})

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							checkThirdParty = false,
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})

			vim.lsp.enable({ "pyright", "lua_ls" })

			local lsp_keymaps = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true })
			vim.api.nvim_create_autocmd("LspAttach", {
				group = lsp_keymaps,
				callback = function(event)
					local map = function(lhs, rhs, desc)
						vim.keymap.set("n", lhs, rhs, { buffer = event.buf, silent = true, desc = desc })
					end

					map("K", vim.lsp.buf.hover, "LSP hover")
					map("gd", vim.lsp.buf.definition, "LSP go to definition")
					map("gD", vim.lsp.buf.declaration, "LSP go to declaration")
					map("gi", vim.lsp.buf.implementation, "LSP go to implementation")
					map("gr", vim.lsp.buf.references, "LSP references")
					map("<leader>rn", vim.lsp.buf.rename, "LSP rename symbol")
					map("<leader>ca", vim.lsp.buf.code_action, "LSP code action")
					map("<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "LSP format buffer")
				end,
			})
		end,
	},
}
