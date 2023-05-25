local indent_blankline = load_plugin("indent_blankline")
if not indent_blankline then
    return
end

indent_blankline.setup {
    show_current_context = true,
    show_current_context_start = true,
    show_current_context_start_on_current_line = true
}
