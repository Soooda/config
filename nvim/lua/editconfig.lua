local function apply(bufnr, config)
	local path = vim.fs.normalize(vim.api.nvim_buf_get_name(bufnr))
	if vim.bo[bufnr].buftype ~= "" or not vim.bo[bufnr].modifiable or path == "" then
		return
	end

	local trim_ws = vim.g.auto_trim_trailing_whitespace_on_save == true

	local default = {
		charset = "utf-8",
		end_of_line = "lf",
		indent_style = "space",
		indent_size = 4,
		insert_final_newline = "true",
		max_line_length = 120,
		tab_width = 4,
		trim_trailing_whitespace = trim_ws and "true" or "false",
	}

	-- YAML
	if path:find("%.ya?ml$") then
		default.indent_style = "space"
	end

	-- Makefiles require tabs in recipes.
	if path:match("Makefile$") or path:match("makefile$") then
		default.indent_style = "tab"
		default.indent_size = "tab"
	end

	local override = {}
	for k, v in pairs(default) do
		if not config[k] then
			config[k] = v
			override[#override + 1] = k
		end
	end

	local editorconfig = require("editorconfig")
	for _, k in ipairs(override) do
		editorconfig.properties[k](bufnr, config[k], override)
	end

	config.root = "true"
end

local group = vim.api.nvim_create_augroup("AutoEditorConfig", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost", "BufFilePost", "FileChangedShellPost" }, {
	group = group,
	callback = function(args)
		if vim.g.auto_editorconfig_defaults == false then
			return
		end

		local opts = vim.b[args.buf]
		opts.editorconfig = opts.editorconfig or {}

		apply(args.buf, opts.editorconfig)
	end,
})
