local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  print("Installing packer close and reopen Neovim...")
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
)

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use 'wbthomason/packer.nvim' -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "tanvirtin/monokai.nvim" -- monokai themes
  use {
    "loctvl842/monokai-pro.nvim",
   -- config = function()
   --   require("monokai-pro").setup()
   -- end
  }

  use { "onsails/lspkind-nvim", event = "VimEnter" } -- icons for auto complete

  -- auto-completion engine
  use { "hrsh7th/nvim-cmp", after = "lspkind-nvim", config = [[require('config.nvim-cmp')]] }
  -- nvim-cmp completion sources
  use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }
  use { "hrsh7th/cmp-path", after = "nvim-cmp" }
  use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }
  use { "hrsh7th/cmp-omni", after = "nvim-cmp" }
  use { "quangnguyen30192/cmp-nvim-ultisnips", after = { "nvim-cmp", "ultisnips" } }
  use { "hrsh7th/cmp-emoji", after = "nvim-cmp" }

  use { 'neovim/nvim-lspconfig', after = "cmp-nvim-lsp", config = [[require('config.lsp')]] }

  -- Snippet engine and snippet template
  use { "SirVer/ultisnips", event = "InsertEnter" }
  use { "honza/vim-snippets", after = "ultisnips" }

  -- for status line at bottom
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    options = { theme = 'molokai' }
  }

  -- for better syntax highlighting and lsp
  use {
        "nvim-treesitter/nvim-treesitter",
        event = "BufEnter",
        run = ":TSUpdate",
        config = [[require('config.treesitter')]],
      }

  use { 'gelguy/wilder.nvim', } -- for autocomplete in cmd line

  -- git commands in vim cmd line
  use {
    'tpope/vim-fugitive'
  }

  -- git changes to left of line nums
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        numhl = true, -- color numbers along with signs to left of them
      })
    end
  }

  -- autocomplete brackets and such
  use {
    "windwp/nvim-autopairs",
    config = function ()
      require('nvim-autopairs').setup{}
    end
  }
  -- Show match number and index for searching
  use {
    "kevinhwang91/nvim-hlslens",
    branch = "main",
    keys = { { "n", "*" }, { "n", "#" }, { "n", "n" }, { "n", "N" } },
    config = [[require('config.hlslens')]],
  }

  -- for fuzzy file searching and rg macros
  use { "Yggdroot/LeaderF", cmd = "Leaderf", run = ":LeaderfInstallCExtension" }

  -- fancy start screen
  use { "nvimdev/dashboard-nvim", event = "VimEnter",
    config = [[require('config.dashboard-nvim')]]
  }

  -- exit insert mode using <j><k>
  use {'jdhao/better-escape.vim', event = 'InsertEnter'}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end

  require('monokai').setup({
    palette = {
      base2 = '#121212', -- make bg darker
      green = '#86fa04', -- i like this green better
    },
  })
  require('lualine').setup()
  require('wilder').setup({modes = {':', '/', '?'}})

end)

