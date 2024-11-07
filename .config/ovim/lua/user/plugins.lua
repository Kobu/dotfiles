-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- return if packer didnt load correctly
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("Error loading packer!", "error")
  return
end

-- Have packer use a popup window
packer.init({
  package_root = "~/.local/share/ovim/site/pack",
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

return packer.startup(function(use)
  use("wbthomason/packer.nvim")
  use({

    "williamboman/mason.nvim",
  })
  use("williamboman/mason-lspconfig.nvim")
  use("shaunsingh/moonlight.nvim")

  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("neovim/nvim-lspconfig")
  use("windwp/nvim-autopairs")
  use({
    "nvimtools/none-ls.nvim",
    requires = {
      "nvimtools/none-ls-extras.nvim",
    },
  })

  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("L3MON4D3/LuaSnip")
  use("lewis6991/gitsigns.nvim")

  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
  })

  use("norcalli/nvim-colorizer.lua")

  use("goolord/alpha-nvim")

  use("kyazdani42/nvim-web-devicons")
  use("kyazdani42/nvim-tree.lua")
  use("akinsho/bufferline.nvim")

  use("nvim-lualine/lualine.nvim")
  use("ThePrimeagen/harpoon")

  use("rcarriga/nvim-notify")
  use("lukas-reineke/indent-blankline.nvim")
  use({ "smartpde/telescope-recent-files" })
  use("folke/tokyonight.nvim")
  use("famiu/bufdelete.nvim")
  use("andweeb/presence.nvim")
  use({
    "folke/todo-comments.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
  })

  use({
    "epwalsh/obsidian.nvim",
    tag = "*",
    requires = {
      "nvim-lua/plenary.nvim",
    },
  })
end)
