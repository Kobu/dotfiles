local null_ls = load_plugin("null-ls")
if not null_ls then
  return
end

local formatting = null_ls.builtins.formatting

null_ls.setup({
  debug = false,
  sources = {
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.xmlformat,
    formatting.stylua,
  },
})
