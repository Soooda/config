local M = {}

M.load = function()
    require("impatient")
    require("plugin-config.autopairs").setup()
    require("plugin-config.treesitter").setup()
    require("plugin-config.comment").setup()
    require("plugin-config.indent-guide").setup()
    require("plugin-config.accelerated-jk").setup()
    require("plugin-config.transparent").setup()
    require("plugin-config.colorizer").setup()
    require("plugin-config.devicons").setup()
    require("plugin-config.symbols-outline").setup()
    require("plugin-config.which-key").setup()
    require("plugin-config.nvim-tree").setup()
    require("plugin-config.gitsigns").setup()
    require("plugin-config.bufferline").setup()
end

return M
