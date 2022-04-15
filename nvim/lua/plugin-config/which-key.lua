local status_ok, wk = pcall(require, "which-key")
if not status_ok then
    print("nvim.which-key launch failed!")
    return
end

wk.setup {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
        presets = {
            operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        ["<space>"] = "SPC",
        ["<cr>"] = "RET",
        ["<CR>"] = "RET",
        ["<tab>"] = "TAB",
        ["<leader>"] = "LEADER"
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = '<c-d>', -- binding to scroll down inside the popup
        scroll_up = '<c-u>', -- binding to scroll up inside the popup
    },
    window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 75, 75, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 0, 2, 0 }, -- extra window padding [top, right, bottom, left]
        winblend = 0
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 100 }, -- min and max width of the columns
        spacing = 1, -- spacing between columns
        align = "center", -- align columns left, center or right
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
    },
}

wk.register({
    ["<leader>"] = {
        name = "LEADER",
        ["0"] = { "Close all tabs except current one" },
        ["1"] = { "Go to the 1st tab" },
        ["2"] = { "Go to the 2nd tab" },
        ["3"] = { "Go to the 3rd tab" },
        ["4"] = { "Go to the 4th tab" },
        ["5"] = { "Go to the 5th tab" },
        ["6"] = { "Go to the 6th tab" },
        ["7"] = { "Go to the 7th tab" },
        ["8"] = { "Go to the 8th tab" },
        ["9"] = { "Go to the 9th tab" },
        c = { "Trigger line comment" },
        cc = { "Trigger line comment" },
        b = { "Trigger block comment"},
        bc = { "Trigger block comment"},
        h = { "Go to the left window" },
        j = { "Go to the bottom window" },
        k = { "Go to the top window" },
        l = { "Go to the right window" },
        ["<cr>"] = { "Quit search" },
        ["<leader>"] = { "Flip layouts" },
        ["<leader>h"] = { "Flip layouts horizontally" },
        ["<leader>j"] = { "Flip layouts vertically" },
    },
    ["s"] = {
        name = "Summon",
        t = { "Create a new tab" },
        h = { "Split horizontally" },
        v = { "Split vertically" },
    },
    -- ["-"] = { "Go to previous match term" },
    -- ["="] = { "Go to next match term" },
    -- ["`"] = { "Change Case" },
    -- ["<Down>"] = { "Shrink current window vertically" },
    -- ["<Up>"] = { "Expand current window vertically" },
    -- ["<Left>"] = { "Shrink current window horizontally" },
    -- ["<Right>"] = { "Expand current window horizontally" },
})
