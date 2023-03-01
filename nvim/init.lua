--[[
 __  ____   __  _   ___     _____ __  __ ____   ____
|  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
| |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |
| |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___
|_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|
Author: @Soooda
--]]


--[[
-- ==============================Plugins========================================
--]]
-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  }

  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  }

  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  use 'lewis6991/gitsigns.nvim' -- Display git symbols for changes
  use 'Mofiqul/dracula.nvim' -- My Favourite Theme
  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
  use 'windwp/nvim-autopairs' -- Auto enclose brackets
  use 'rainbowhxch/accelerated-jk.nvim' -- Improve j/k scrolling speed
  use 'yamatsum/nvim-cursorline' -- Display cursor line
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use 'tpope/vim-sleuth' -- Automatically set tab information based on the file opened
  use 'nvim-tree/nvim-web-devicons' -- Icons
  use 'nvim-lualine/lualine.nvim' -- Status line
  use 'norcalli/nvim-colorizer.lua' -- Colorizer
  use 'folke/which-key.nvim' -- Which-key
  use 'ojroques/nvim-scrollbar' -- Scroll Bar

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})


--[[
-- ==============================Setting Options================================
--]]
-- See `:help vim.o`

-- Visual Bell
vim.o.visualbell = true

-- Set highlight on search
vim.o.hlsearch = true
vim.cmd('nohlsearch') -- Disable Highlight Search on launch

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Make line numbers default
vim.wo.number = true

-- Display the active line and Only highlight the active line number
vim.o.cursorline = true
vim.o.cursorlineopt = "number"

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Decrease update time
vim.o.updatetime = 250

-- Display the sign column only when there are signs to display
vim.wo.signcolumn = 'auto'

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd('colorscheme dracula')

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 4

-- Default split screens to the right and below
vim.o.splitright = true
vim.o.splitbelow = true

-- Set Tab Stop
vim.o.tabstop = 4

-- Set using the system clipboard
vim.go.clipboard = "unnamedplus"

-- Restore cursor position
vim.cmd [[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]


--[[
-- ==============================Basic Keymaps=================================
--]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<NOP>', { silent = true })

-- The default j and k motions move across physical lines, not the visible, soft-wrapped screen lines
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Colon Shortcut by simply pressing the semicolon
vim.keymap.set('n', ';', ':', { silent = true, desc = "Input Command (just like :)" })

-- Press shift + q to quit
vim.keymap.set('n', 'Q', ':q<CR>', { silent = true, desc = "Quit" })

-- Press shift + s to save
vim.keymap.set('n', 'S', ':w<CR>', { silent = true, desc = "Save" })

-- Press shift + u to redo
vim.keymap.set('n', 'U', '<C-r>', { silent = true, desc = "Redo" })

-- Press shift + h/l to go to the first/last char of the line
vim.keymap.set({ 'n', 'v' }, 'H', '0', { silent = true, desc = "Go to the first character" })
vim.keymap.set({ 'n', 'v' }, 'L', '$', { silent = true, desc = "Go to the last character" })

-- Press leader + enter to stop search (no highlight search)
vim.keymap.set({ 'n', 'v' }, '<LEADER><CR>', ':nohlsearch<CR>',
  { silent = true, desc = "Turn off the search highlights" })

-- Press -/= to go to the previous/next found item and center
vim.keymap.set({ 'n', 'v' }, '-', 'Nzz', { silent = true, desc = "Go to the previous found item" })
vim.keymap.set({ 'n', 'v' }, '=', 'nzz', { silent = true, desc = "Go to the next found item" })

-- Press ` to switch case of the selected character
vim.keymap.set({ 'n', 'v' }, '`', '~', { silent = true, desc = "Switch Case" })

-- Press </> to indent left/right
vim.keymap.set('n', '<', '<<', { silent = true, desc = "Indent one level" })
vim.keymap.set('n', '>', '>>', { silent = true, desc = "Un-indent one level" })
vim.keymap.set('v', '<', '<gv', { silent = true, desc = "Indent one level" })
vim.keymap.set('v', '>', '>gv', { silent = true, desc = "Un-indent one level" })

-- Press arrow keys to resize sub-screens
vim.keymap.set('n', '<UP>', ':res +5<CR>', { silent = true, desc = "Decrease window height" })
vim.keymap.set('n', '<DOWN>', ':res -5<CR>', { silent = true, desc = "Increase window height" })
vim.keymap.set('n', '<LEFT>', ':vertical resize-5<CR>', { silent = true, desc = "Decrease window width" })
vim.keymap.set('n', '<RIGHT>', ':vertical resize+5<CR>', { silent = true, desc = "Increase window width" })

-- Press leader + h/j/k/l to move the cursor around sub-screens
vim.keymap.set('n', '<LEADER>h', '<C-w>h', { silent = true, desc = "Go to the left screen" })
vim.keymap.set('n', '<LEADER>j', '<C-w>j', { silent = true, desc = "Go to the lower screen" })
vim.keymap.set('n', '<LEADER>k', '<C-w>k', { silent = true, desc = "Go to the upper screen" })
vim.keymap.set('n', '<LEADER>l', '<C-w>l', { silent = true, desc = "Go to the right screen" })

-- Press leader + 1-9 to switch tabs
vim.keymap.set('n', '<LEADER>1', '1gt', { silent = true, desc = "Go to Tab 1" })
vim.keymap.set('n', '<LEADER>2', '2gt', { silent = true, desc = "Go to Tab 2" })
vim.keymap.set('n', '<LEADER>3', '3gt', { silent = true, desc = "Go to Tab 3" })
vim.keymap.set('n', '<LEADER>4', '4gt', { silent = true, desc = "Go to Tab 4" })
vim.keymap.set('n', '<LEADER>5', '5gt', { silent = true, desc = "Go to Tab 5" })
vim.keymap.set('n', '<LEADER>6', '6gt', { silent = true, desc = "Go to Tab 6" })
vim.keymap.set('n', '<LEADER>7', '7gt', { silent = true, desc = "Go to Tab 7" })
vim.keymap.set('n', '<LEADER>8', '8gt', { silent = true, desc = "Go to Tab 8" })
vim.keymap.set('n', '<LEADER>9', '9gt', { silent = true, desc = "Go to Tab 9" })

-- Press leader + 0 to close all the other tabs
vim.keymap.set('n', '<LEADER>0', ':tabo<CR>', { silent = true, desc = "Close any other tabs" })

-- Press leader + leader + h/j to change the sub-screen layout to horizontal/vertical
vim.keymap.set('n', '<LEADER><LEADER>h', '<C-w>H', { silent = true, desc = "Sub-screen layout -> horizontal" })
vim.keymap.set('n', '<LEADER><LEADER>j', '<C-w>J', { silent = true, desc = "Sub-screen layout -> vertical" })

-- Press s + h/v to split a sub-screen horizontally/vertically
vim.keymap.set('', 's', '<NOP>', {}) -- Reassign s key to no action
vim.keymap.set('n', 'sh', ':set splitright<cr>:vsplit<CR>', { silent = true, desc = "[S]pawn a screen [H]orizontally" })
vim.keymap.set('n', 'sv', ':set splitbelow<cr>:split<CR>', { silent = true, desc = "[S]pawn a screen [V]ertically" })

-- Press s + t to spawn a new tab
vim.keymap.set('n', 'st', ':tabnew<CR>', { silent = true, desc = "[S]pawn a new [T]ab" })

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})


--[[
-- ==============================Plugin Configs=================================
--]]
-- [[ nvim-treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'help', 'vim' },

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<C-space>',
      node_incremental = '<C-space>',
      scope_incremental = '<C-s>',
      node_decremental = '<C-backspace>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<LEADER>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<LEADER>A'] = '@parameter.inner',
      },
    },
  },
}
-- [[ indent-blankline.nvim ]]
-- See `:help indent_blankline.txt`
require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
  use_treesitter = true,
  show_current_context = true,
  show_current_context_start = true,
}
vim.cmd [[highlight IndentBlanklineContextChar guifg=#62646C gui=nocombine]]
-- [[ nvim-autopairs ]]
-- See `:help indent_blankline.txt`
require('nvim-autopairs').setup {
  check_ts = true,
}
-- [[ nvim-cursorline ]]
require('nvim-cursorline').setup {
  cursorline = {
    enable = true,
    timeout = 1000,
    number = false,
  },
  cursorword = {
    enable = true,
    min_length = 3,
    hl = { underline = true },
  }
}
-- [[ Comment.nvim ]]
-- See `:help comment-nvim`
require('Comment').setup()
-- [[ gitsigns.nvim ]]
-- See `:help gitsigns.txt`
require('gitsigns').setup {
  signs = {
    add = { text = '▎' },
    change = { text = '░' },
    delete = { text = '▏' },
    topdelete = { text = '▔' },
    changedelete = { text = '▒' },
    untracked    = { text = '+' },
  },
}
--[[ accelerated-jk.nvim ]]
vim.keymap.set('n', 'j', '<Plug>(accelerated_jk_gj)', {})
vim.keymap.set('n', 'k', '<Plug>(accelerated_jk_gk)', {})
require('accelerated-jk').setup({
  mode = 'time_driven',
  enable_deceleration = false,
  acceleration_motions = {},
  acceleration_limit = 150,
  acceleration_table = { 3, 6, 9, 12, 15, 18, 23, 28, 30 },
  -- when 'enable_deceleration = true', 'deceleration_table = { {200, 3}, {300, 7}, {450, 11}, {600, 15}, {750, 21}, {900, 9999} }'
  deceleration_table = { { 150, 9999 } }
})
-- [[ lualine.nvim ]]
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'dracula-nvim',
    component_separators = '│',
    section_separators = ' ',
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { "string.format('R:%3d C:%-2d', vim.fn.line('.'), vim.fn.virtcol('.'))" },
    lualine_c = { 'filename' },
    lualine_x = {},
    lualine_y = { 'diagnostics', 'diff', 'branch' },
    lualine_z = { 'filesize' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { "string.format('R:%3d C:%-2d', vim.fn.line('.'), vim.fn.virtcol('.'))" },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
-- [[ nvim-web-devicons ]]
require('nvim-web-devicons').setup {
  -- your personnal icons can go here (to override)
  -- you can specify color or cterm_color instead of specifying both of them
  -- DevIcon will be appended to `name`
  override = {},
  -- globally enable different highlight colors per icon (default to true)
  -- if set to false all icons will have the default icon's color
  color_icons = true,
  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  default = true,
}
-- [[ nvim-colorizer.lua ]]
require('colorizer').setup({
  '*'; -- Highlight all files
  css = { css = true };
}, { mode = 'background' })
--[[ which-key.nvim ]]
vim.o.timeout = true
vim.o.timeoutlen = 300
local wk = require('which-key')
wk.setup {
  window = {
    border = "rounded",
    margin = { 1, 60, 1, 0 },
  },
}
-- [[ nvim-scrollbar ]]
require('scrollbar').setup {
  symbol_bar = { ' ', 'Search' }, -- Bar symbol and highlight group
  priority = 10, -- Priority of scrollbar (low value = high priority)
  exclude_buftypes = {}, -- Buftypes to exclude
  exclude_filetypes = { -- Filetypes to exclude
    'qf',
  },
  render_events = { -- Events triggering the redraw of the bar
    'BufWinEnter',
    'CmdwinLeave',
    'TabEnter',
    'TermEnter',
    'TextChanged',
    'VimResized',
    'WinEnter',
    'WinScrolled',
  },
}
-- [[ telescope.nvim ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })


--[[
-- ========================LSP and Auto Completion==============================
--]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- rust_analyzer = {},
  -- tsserver = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  pyright = {},
}

-- Setup neovim lua configuration
require('neodev').setup()
--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup {
  ui = {
    border = "rounded",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    },
  }
}

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- Turn on lsp status information
require('fidget').setup()

--[[ nvim-cmp ]]
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete({}),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to the previous diagnosis" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to the next diagnosis" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show diagnostics in a floating window" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Go to the previous diagnosis" })
--[[
-- ===================================End=======================================
--]]

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
