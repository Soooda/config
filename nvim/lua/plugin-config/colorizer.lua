require('colorizer').setup({
    '*'; -- Highlight all files
    '!vim'; -- Exclude vim from highlighting
    -- Exclusion Only makes sense if '*' is specified!
}, { mode = 'background' })
