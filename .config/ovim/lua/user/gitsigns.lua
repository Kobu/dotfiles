local gitsigns = load_plugin("gitsigns")
if not gitsigns then
  return
end

gitsigns.setup({
  signs = {
    add = { hl = "GitSignsAdd", text = "+", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "-", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "-", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },

  vim.keymap.set("n", "ghs", gitsigns.stage_hunk, {}),
  vim.keymap.set("n", "ghu", gitsigns.undo_stage_hunk, {}),
  vim.keymap.set("n", "ghv", gitsigns.select_hunk, {}),
  vim.keymap.set("n", "<C-j>", gitsigns.next_hunk, {}),
  vim.keymap.set("n", "<C-k>", gitsigns.prev_hunk, {}),
  vim.keymap.set("n", "ghr", gitsigns.reset_hunk, {}),
  vim.keymap.set("n", "ghp", gitsigns.preview_hunk_inline, {}),
})
