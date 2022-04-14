local M = {}

M.setup = function()
    local status_ok, indent_blankline = pcall(require, "indent_blankline")
    if not status_ok then
        print("Indent-blankline launch failed!")
        return
    end

    indent_blankline.setup {
        show_trailing_blankline_indent = false,
        space_char_blankline = " ",
        use_treesitter = true,
        show_current_context = true,
        show_current_context_start = true,
    }

    -- vim.cmd[[highlight IndentBlanklineContextChar guifg=#62646C gui=nocombine]]
    vim.cmd[[highlight IndentBlanklineContextChar guifg=#FFFFFF gui=nocombine]]
end

return M
