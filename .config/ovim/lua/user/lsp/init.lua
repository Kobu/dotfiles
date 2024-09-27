require("mason").setup()
local lsp_installer = load_plugin("mason-lspconfig")
if not lsp_installer then
  return
end

local servers = {
  "lua_ls",
  "pyright",
  "clangd",
  "bashls",
  "ts_ls",
  "emmet_ls",
  "cssls",
  "marksman",
  "omnisharp",
  -- "hls",
  "lemminx",
  "prismals",
  "tailwindcss",
  "jsonls",
}

local lspconfig = require("lspconfig")

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
local workspace = {
  didChangeWatchedFiles = {
    dynamicRegistration = false,
  },
}

capabilities.workspace = workspace

-- buffer = 0 : current buffer
local on_attach = function(_, bufnr)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
  vim.keymap.set("n", "R", vim.lsp.buf.rename, { buffer = 0 })
  vim.keymap.set("n", "sk", vim.diagnostic.goto_prev)
  vim.keymap.set("n", "sj", vim.diagnostic.goto_next)
  vim.keymap.set("n", "sa", vim.lsp.buf.code_action, { buffer = 0 })
end

for _, server in pairs(servers) do
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers,
  }

  local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
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

lsp_installer.setup({
  ensure_installed = servers,
})
