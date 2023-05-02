local opts = {noremap = false, silent = true}

local keymap = vim.api.nvim_set_keymap

-- set <Space> as leader key
vim.keymap.set("n", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- indent blocks selected in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- comment out current line a go to next line
vim.keymap.set("n", "<C-_>",
  function()
    require("Comment.api").toggle.linewise()
    vim.cmd('+1')
  end
)
-- comment out highlighted block
vim.keymap.set("v", "<C-_>",
  "<ESC><cmd>lua require('Comment.api').toggle.linewise_op(vim.fn.visualmode())<CR>")

-- nvimtree keymaps
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
keymap("n", "<C-n>", ":NvimTreeFocus<CR>", opts)
-- "r" => rename file
-- "d" => delete file
-- "a" => create file

keymap("n", "L", ":BufferLineCycleNext<CR>", opts)
keymap("n", "H", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "B", ":Bdelete<CR>", opts)

keymap("n", "<C-l>", ":source $MYVIMRC<CR>", opts)

keymap("n", "gf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
