require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
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
require "user.lsp"
