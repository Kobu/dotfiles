require('neogen').setup {
    enabled = true,
}
vim.keymap.set("n", "sp", function()
    require('neogen').generate({
        type="func"
    })
end, {})
