local telescope = load_plugin("telescope")
if not telescope then
  return
end

local builtin = load_plugin("telescope.builtin")
if not builtin then
  return
end

local actions = load_plugin("telescope.actions")
if not actions then
  return
end

local action_state = load_plugin("telescope.actions.state")
if not action_state then
  return
end

local hot_keys = load_plugin("user.hot-keys")
if not hot_keys then
  return
end

vim.keymap.set("n", "<leader>aa", builtin.find_files, {})
vim.keymap.set("n", "<leader>lg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>ht", builtin.help_tags, {})
vim.keymap.set("n", "<leader>hk", function ()
    hot_keys.picker(require("telescope.themes").get_dropdown{})
end, {})
vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
vim.keymap.set("n", "<leader>gb", builtin.git_branches, {})
vim.keymap.set("n", "<leader>gi", builtin.lsp_implementations, {})
vim.keymap.set("n", "gl", function()
  builtin.git_commits({
    git_command = { "git", "log", "--format=%C(bold blue)%h %C(211)[Date: %as] %C(magenta)[%an] %Creset%s" },

  })
end, {})
vim.keymap.set("n", "<leader>ff", function()
  vim.fn.system("git rev-parse --is-inside-work-tree 2> /dev/null")
  if vim.v.shell_error == 0 then
    builtin.git_files()
  else
    builtin.find_files()
  end
end, {})
vim.keymap.set("n", "<leader>r", function()
  builtin.lsp_references({ jump_type = "never" })
end, {})
vim.keymap.set("n", "e", builtin.resume, {})
vim.keymap.set("n", "<leader>td", ":TodoTelescope<CR>", {})

local function getSha()
  local selection = action_state.get_selected_entry()
  local sha = selection.value
  vim.fn.system("echo " .. sha .. " | xclip -selection clipboard")
  if vim.v.shell_error ~= 0 then
    vim.notify("Error copying the SHA", "error")
    return
  end
  vim.notify("Copied " .. sha .. " to clipboard")
end

local function doRebase(bufnr)
  local selection = action_state.get_selected_entry()
  local sha = selection.value
  actions.smart_send_to_qflist(bufnr)
  vim.cmd("Git rebase -i " .. sha .. "^")
end

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
  pickers = {
    git_bcommits = {
      mappings = {
        i = {
          ["<cr>"] = actions.select_vertical,
        },
      },
    },
    git_commits = {
      mappings = {
        i = {
          ["<cr>"] = getSha,
          ["R"] = doRebase,
        },
      },
    },
  },
})
