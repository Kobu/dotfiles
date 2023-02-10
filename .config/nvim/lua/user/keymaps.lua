local opts = {noremap = true, silent = true}

local keymap = vim.api.nvim_set_keymap

keymap("n", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "


keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)


keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

