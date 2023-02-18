-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- return if packer didnt load correctly
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  -- put notification here
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)
  use "wbthomason/packer.nvim"
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
         }
  use "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "folke/tokyonight.nvim"
  use "L3MON4D3/LuaSnip"
  use "windwp/nvim-autopairs"
  use "EdenEast/nightfox.nvim"
end)