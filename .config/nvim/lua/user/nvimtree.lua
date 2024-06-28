local nvim_tree = load_plugin("nvim-tree")
if not nvim_tree then
  return
end

local api = require("nvim-tree.api")

local function on_attach(bufnr)
  local function opts(desc)
    return { desc = "nvim-tree: ", buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts())
  vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts())
  vim.keymap.set("n", "<C-h>", api.node.open.horizontal, opts())
  vim.keymap.set("n", "a", api.fs.create, opts())
  vim.keymap.set("n", "d", api.fs.remove, opts())
  vim.keymap.set("n", "E", api.tree.expand_all, opts())
  vim.keymap.set("n", "g?", api.tree.toggle_help, opts())
  vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts())
  vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts())
  vim.keymap.set("n", "r", api.fs.rename, opts())
  vim.keymap.set("n", "W", api.tree.collapse_all, opts())
  vim.keymap.set("n", "y", api.fs.copy.filename, opts())
  vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts())
  vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts())
  vim.keymap.set("n", "<CR>", api.node.open.edit, opts())
  vim.keymap.set("n", "<C-a>", function()
    local lib = require("nvim-tree.lib")
    local node = lib.get_node_at_cursor()

    if node then
      require("harpoon.mark").add_file(node.absolute_path)
      vim.notify("Added file to harpoon")
    end
  end)
end

vim.keymap.set("n", "<leader>e", api.tree.toggle)
vim.keymap.set("n", "<C-n>", api.tree.focus)
vim.keymap.set("n", "<C-f>", function()
  api.tree.find_file({
    open = true,
    focus = true,
  })
end)

nvim_tree.setup({
  on_attach = on_attach,
  disable_netrw = true,
  hijack_cursor = true,
  update_cwd = true,
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    adaptive_size = true,
    width = 30,
    side = "left",
    --[[ mappings = { ]]
    --[[ custom_only = false, ]]
    --[[ }, ]]
    number = false,
    signcolumn = "yes",
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  renderer = {
    add_trailing = true,
    highlight_git = true,
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = false,
      },
      glyphs = {
        default = "",
        symlink = "",
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          deleted = "",
          untracked = "U",
          ignored = "◌",
        },
      },
    },
  },
})
