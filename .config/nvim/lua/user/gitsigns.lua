local gitsigns = load_plugin("gitsigns")
if not gitsigns then
  return
end

gitsigns.setup({
  signs = {
    add = { text = "┃" },
    change = { text = "┃" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true,
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 200,
    ignore_whitespace = false,
    virt_text_priority = 100,
  },
  current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },

  vim.keymap.set("n", "ghs", gitsigns.stage_hunk, {}),
  vim.keymap.set("n", "ghu", gitsigns.undo_stage_hunk, {}),
  vim.keymap.set("n", "ghv", gitsigns.select_hunk, {}),
  vim.keymap.set("n", "<C-j>", gitsigns.next_hunk, {}),
  vim.keymap.set("n", "<C-k>", gitsigns.prev_hunk, {}),
  vim.keymap.set("n", "ghr", gitsigns.reset_hunk, {}),
  vim.keymap.set("n", "ghp", gitsigns.preview_hunk_inline, {}),
})
