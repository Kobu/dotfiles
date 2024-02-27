local null_ls = load_plugin("null-ls")
if not null_ls then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  debug = false,
  sources = {
    -- formatting
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.xmlformat,
    formatting.stylua,
    formatting.eslint_d,

    -- diagnostics
    diagnostics.eslint_d,

    -- code_actions
    code_actions.eslint_d,
  },
})
