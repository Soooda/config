local M = {}

M.setup = function()
    require('colorizer').setup({
        '*'; -- Highlight all files
        '!vim'; -- Exclude vim from highlighting
        -- Exclusion Only makes sense if '*' is specified!
    }, { mode = 'background' })
end

return M
