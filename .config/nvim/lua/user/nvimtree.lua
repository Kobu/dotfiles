local nvim_tree = load_plugin("nvim-tree")
if not nvim_tree then
    return
end

local api = require("nvim-tree.api")

vim.keymap.set("n", "<C-k>", api.node.show_info_popup)
vim.keymap.set("n", "<C-v>", api.node.open.vertical)
vim.keymap.set("n", "<C-h>", api.node.open.horizontal)
vim.keymap.set("n", "<C-n>", api.tree.focus)
vim.keymap.set("n", "<CR>", api.node.open.edit)
vim.keymap.set("n", "a", api.fs.create)
vim.keymap.set("n", "d", api.fs.remove)
vim.keymap.set("n", "E", api.tree.expand_all)
vim.keymap.set("n", "g?", api.tree.toggle_help)
vim.keymap.set("n", "H", api.tree.toggle_hidden_filter)
vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter)
vim.keymap.set("n", "r", api.fs.rename)
vim.keymap.set("n", "W", api.tree.collapse_all)
vim.keymap.set("n", "y", api.fs.copy.filename)
vim.keymap.set("n", "Y", api.fs.copy.relative_path)
vim.keymap.set("n", "gy", api.fs.copy.absolute_path)
vim.keymap.set("n", "<C-f>", function()
    api.tree.find_file({
        open = true,
        focus = true,
    })
end)

nvim_tree.setup({
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
                folder = {
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                },
            },
        },
    },
})
