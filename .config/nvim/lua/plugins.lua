return require("packer").startup(function()
	use("wbthomason/packer.nvim")
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("neovim/nvim-lspconfig")
end)
