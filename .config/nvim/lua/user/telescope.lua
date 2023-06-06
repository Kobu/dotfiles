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


vim.keymap.set("n", "<leader>aa", builtin.find_files, {})
vim.keymap.set("n", "<leader>lg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>ht", builtin.help_tags, {})
vim.keymap.set("n", "<leader>ff", builtin.git_files, {})
vim.keymap.set("n", "<leader>r", builtin.lsp_references, {})
vim.keymap.set("n", "e", builtin.resume, {})


telescope.setup({
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
        },
    },
})
