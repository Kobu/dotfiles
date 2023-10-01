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

vim.keymap.set("n", "<leader>aa", builtin.find_files, {})
vim.keymap.set("n", "<leader>lg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>ht", builtin.help_tags, {})
vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
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
vim.keymap.set("n", "<leader>r", function ()
    builtin.lsp_references({jump_type="never"})
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
      attach_mappings = function(_, map)
        map("i", "<cr>", getSha)
        return true
      end,
    },
  },
})
