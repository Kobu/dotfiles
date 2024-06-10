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

  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("neovim/nvim-lspconfig")

  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("L3MON4D3/LuaSnip")

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
    "epwalsh/obsidian.nvim",
    tag = "*", -- recommended, use latest release instead of latest commit
    requires = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    config = function()
      require("obsidian").setup({
        workspaces = {
          {
            name = "personal",
            path = "~/vaults/personal",
          },
          {
            name = "work",
            path = "~/vaults/work",
          },
        },

        -- see below for full list of options 👇
      })
    end,
  })
end)
