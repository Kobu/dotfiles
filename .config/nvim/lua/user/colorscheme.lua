vim.cmd[[colorscheme tokyonight-night]]

vim.cmd("highlight NotifyERRORBorder guifg=#8A1F1F")
vim.cmd("highlight NotifyWARNBorder guifg=#79491D")
vim.cmd("highlight NotifyINFOBorder guifg=#4F6752")
vim.cmd("highlight NotifyDEBUGBorder guifg=#8B8B8B")
vim.cmd("highlight NotifyTRACEBorder guifg=#4F3552")
vim.cmd("highlight NotifyERRORIcon guifg=#F70067")
vim.cmd("highlight NotifyWARNIcon guifg=#F79000")
vim.cmd("highlight NotifyINFOIcon guifg=#A9FF68")
vim.cmd("highlight NotifyDEBUGIcon guifg=#8B8B8B")
vim.cmd("highlight NotifyTRACEIcon guifg=#D484FF")
vim.cmd("highlight NotifyERRORTitle  guifg=#F70067")
vim.cmd("highlight NotifyWARNTitle guifg=#F79000")
vim.cmd("highlight NotifyINFOTitle guifg=#A9FF68")
vim.cmd("highlight NotifyDEBUGTitle  guifg=#8B8B8B")
vim.cmd("highlight NotifyTRACETitle  guifg=#D484FF")
vim.cmd("highlight link NotifyERRORBody Normal")
vim.cmd("highlight link NotifyWARNBody Normal")
vim.cmd("highlight link NotifyINFOBody Normal")
vim.cmd("highlight link NotifyDEBUGBody Normal")
vim.cmd("highlight link NotifyTRACEBody Normal")


vim.cmd [[highlight YankHighlight guibg=lightblue guifg=#000000 ctermbg=lightblue ctermfg=black]]

-- Create an autocommand to highlight yanked text
vim.api.nvim_exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="YankHighlight", timeout=150}
  augroup END
]], false)
