require('plugins')
require "user.options"
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
--vim.opt.foldmethod = "expr"
--vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
local cmp = require'cmp'

  cmp.setup({
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })



local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require'lspconfig'.pyright.setup{
				capabilities = capabilities,
				on_attach = function()
								print("hello wolrd")
								vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
								vim.keymap.set("n", "gr", vim.lsp.buf.rename, {buffer=0})
								vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0}) -- Ctrl + t to jump back
				end,
}
