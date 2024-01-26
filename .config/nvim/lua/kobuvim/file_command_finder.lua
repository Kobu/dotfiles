local pickers = load_plugin("telescope.pickers")
if not pickers then
    return
end

local previewers = load_plugin("telescope.previewers")
if not previewers then
    return
end

local finders = load_plugin("telescope.finders")
if not finders then
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


local M = {}

M.replace_picker = function(prompt_bufnr)
    return function()
        local cmd = action_state.get_current_line()
        actions.close(prompt_bufnr)
        M.file_command_picker(cmd, { default_text = cmd }):find()
    end
end

M.file_command_picker = function(command, opts)
    opts = opts or {}
    local result = vim.run_command(command, { ignore_stderr = true })
    return pickers.new(opts, {
        prompt_title = "Command",
        finder = finders.new_table({
            results = result,
            entry_maker = function(entry)
                return {
                    value = entry,
                    path = entry,
                    ordinal = entry,
                    display = entry
                }
            end
        }),
        previewer = previewers.vim_buffer_cat.new(opts),
        attach_mappings = function(prompt_bufnr, map)
            map('i', '<C-x>', M.replace_picker(prompt_bufnr))
            map('n', '<C-x>', M.replace_picker(prompt_bufnr))
            map("i", "<C-Down>", actions.cycle_history_next)
            map("i", "<C-Up>", actions.cycle_history_prev)
            map("n", "<C-Down>", actions.cycle_history_next)
            map("n", "<C-Up>", actions.cycle_history_prev)

            return true
        end
    })
end

vim.keymap.set("n", "<leader>cm", function()
    M.file_command_picker(""):find()
end, {})
