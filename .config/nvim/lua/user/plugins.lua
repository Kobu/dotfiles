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
  use("tpope/vim-fugitive")

  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })
  use("neovim/nvim-lspconfig")
  use("williamboman/nvim-lsp-installer")

  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("L3MON4D3/LuaSnip")
  use("jose-elias-alvarez/null-ls.nvim")

  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
  })

  use("shaunsingh/moonlight.nvim")
  use("p00f/nvim-ts-rainbow")
  use("norcalli/nvim-colorizer.lua")

  use("windwp/nvim-autopairs")

  use("numToStr/Comment.nvim")
  use("JoosepAlviste/nvim-ts-context-commentstring")

  use("goolord/alpha-nvim")

  use("kyazdani42/nvim-web-devicons")
  use("kyazdani42/nvim-tree.lua")
  use("akinsho/bufferline.nvim")
  use("moll/vim-bbye")

  use("weirongxu/plantuml-previewer.vim")
  use("tyru/open-browser.vim")
  use("aklt/plantuml-syntax")

  use("nvim-lualine/lualine.nvim")
  use("previm/previm")

  use("lewis6991/gitsigns.nvim")
  use("rcarriga/nvim-notify")
  use("lukas-reineke/indent-blankline.nvim")
  use({
    "folke/todo-comments.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
  })
  use("ray-x/lsp_signature.nvim")
end)
