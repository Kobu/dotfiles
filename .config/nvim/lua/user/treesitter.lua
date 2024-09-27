local treesitter_config = load_plugin("nvim-treesitter.configs")
if not treesitter_config then
  return
end

treesitter_config.setup({
  ensure_installed = {
    "c",
    "lua",
    "python",
    "javascript",
    "haskell",
    "prisma",
    "typescript",
    "html",
    "css",
    "tsx",
    "regex",
    "bash",
    "json",
    "markdown",
    "markdown_inline",
    "sql",
    "glimmer",
    "rust"
  },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "yaml" } },
  rainbow = {
    enable = false,
    extended_mode = true,
    max_file_lines = nil,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<space>ts",
      node_incremental = "m",
      node_decremental = "M",
    },
  },
})
