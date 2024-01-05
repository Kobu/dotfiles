vim.opt.tabstop = 8
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.relativenumber = true
vim.opt.nu = true
vim.opt.backup = false
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.termguicolors = true
vim.g.mapleader = " "
vim.g.skip_ts_context_commentstring_module = true

-- keep signcolumn visible to avoid LSP "stutter" on completion
vim.opt.signcolumn = "yes"

-- delete tildas after EOFs
vim.opt.fcs = "eob: "
