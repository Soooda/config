local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

    use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
    use 'williamboman/nvim-lsp-installer'

    -- Colorschemes
    use "Mofiqul/dracula.nvim"
    use({
        "catppuccin/nvim",
        as = "catppuccin"
    })

    use 'lewis6991/impatient.nvim' -- Fast start up
    use 'windwp/nvim-autopairs' -- Autopairs
    use 'numToStr/Comment.nvim' -- Comment
    use 'lukas-reineke/indent-blankline.nvim' -- Indent Guide
    use 'xiyaowong/accelerated-jk.nvim' -- Fast j/k travel
    use 'yamatsum/nvim-cursorline' -- Cursor line
    use 'xiyaowong/nvim-transparent' -- Transparent Background
    use 'norcalli/nvim-colorizer.lua' -- Color Code Highlighting
    use 'kyazdani42/nvim-web-devicons' -- Icons
    use 'folke/which-key.nvim' -- Which-key
    use 'simrat39/symbols-outline.nvim' -- Tags
    use 'kyazdani42/nvim-tree.lua' -- File Explorer
    use 'lewis6991/gitsigns.nvim' -- Git Signs
    use 'akinsho/bufferline.nvim' -- Buffer Line

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }

    use 'rcarriga/nvim-notify' -- Notification Popup

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
