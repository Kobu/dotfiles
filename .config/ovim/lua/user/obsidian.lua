local obsidian = load_plugin("obsidian")
if not obsidian then
  return
end

obsidian.setup({
  workspaces = {
    {
      name = "main",
      path = "~/files/obsidian/main",
    },
  },
  completion = {
    nvim_cmp = true,
  },
  templates = {
    folder = "/home/kobu/files/obsidian/main/templates/",
    date_format = "%Y-%m-%d-%a",
    time_format = "%H:%M",
  },
})

vim.keymap.set("n", "<leader>ot", ":ObsidianTags<cr>", { nowait = true })
