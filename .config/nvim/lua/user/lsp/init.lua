local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local lspconfig = require("lspconfig")

local servers = {
  lua = "lua_ls",
  python = "pyright",
  c = "clangd",
  typescript = "tsserver",
  javascript = "tsserver",
  html = "emmet_ls",
  css = "cssls",
  markdown = "marksman",
  csharp = "omnisharp",
  haskell = "hls",
  xml = "lemminx",
  prisma = "prismals",
}

lsp_installer.setup({
  ensure_installed = servers,
})

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "double" }),
}
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function()
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
  vim.keymap.set("n", "R", vim.lsp.buf.rename, { buffer = 0 })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })
  vim.keymap.set("n", "gp", vim.diagnostic.goto_prev)
  vim.keymap.set("n", "gn", vim.diagnostic.goto_next)
  vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { buffer = 0 })
end

for lang, server in pairs(servers) do
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers,
  }

  local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. lang)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
  end

  lspconfig[server].setup(opts)
end

vim.diagnostic.config({
  update_in_insert = true,
  float = {
    show_header = true,
    source = "if_many",
    border = "rounded",
    focusable = false,
  },
  severity_sort = true,
  signs = true,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
