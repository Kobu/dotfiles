local opts = {noremap = false, silent = true}

local keymap = vim.api.nvim_set_keymap

-- set <Space> as leader key
vim.keymap.set("n", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "


keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)


keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
-- comment out current line a go to next line
vim.keymap.set("n", "<C-_>",
  function()
    require("Comment.api").toggle_current_linewise()
    vim.cmd('+1')
  end
)
-- comment out highlighted block
vim.keymap.set("v", "<C-_>",
  "<ESC><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>")

