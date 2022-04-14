local M = {}

M.setup = function()
    require('nvim-web-devicons').setup {
        override = {};
        default = true;
    }
end

return M
