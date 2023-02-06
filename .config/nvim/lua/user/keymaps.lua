local opts = {noremap = true, silent = true}

local keymap = vim.api.nvim_set_keymap

keymap("n", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

