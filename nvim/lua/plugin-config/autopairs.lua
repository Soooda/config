local M = {}

local opt = {
    check_ts = true
}

M.setup = function()
    local autopairs = require "nvim-autopairs"
    local Rule = require "nvim-autopairs.rule"

    autopairs.setup(opt)
end

return M
