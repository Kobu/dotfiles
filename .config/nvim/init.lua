require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
require("nvim-lsp-installer").setup{}
require "user.autopairs"
local configs = require'nvim-treesitter.configs'

configs.setup {
ensure_installed = {"c", "lua", "python", "javascript"} , -- Only use parsers that are maintained
highlight = { -- enable highlighting
  enable = true,
},
indent = {
  enable = true,
}
}
local lspconfig = require("lspconfig")

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())


local on_attach = function()
								vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
								vim.keymap.set("n", "gr", vim.lsp.buf.rename, {buffer=0})
								vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
end
lspconfig.pyright.setup{
  capabilities = capabilities,
  on_attach = on_attach
}
lspconfig.sumneko_lua.setup{
  capabilities=capabilities,
  settings = { Lua = { diagnostics = {globals = {"vim", "use"}}}},
  on_attach = on_attach
}
