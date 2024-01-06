local pickers = require "telescope.pickers"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local M = {}

local function mysplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

local function postProcess(raw_string)
    local inputstr, _ = raw_string:match("%S+")
    if inputstr:find("<C-", 1, true) == 1 then
        return inputstr, "\\" .. inputstr
    end

    if inputstr:find("<leader>", 1, true) == 1 then
        return inputstr, " " .. string.sub(inputstr, 9, -1)
    end

    return inputstr, inputstr
end


local function test(arr)
    local t = {}
    for _, armyName in ipairs(arr) do
        table.insert(t, { armyName })
    end

    return t
end

function M.picker(opts)
    opts = opts or {}
    pickers.new(opts, {
        prompt_title = "colors",
        finder = finders.new_table {

            results = test(mysplit(vim.fn.system("cat /home/kobu/.config/nvim/hot-keys"), "\n")),
            entry_maker = function(entry)
                local display_keymap, exec_keymap = postProcess(entry[1])
                return {
                    value = entry,
                    display = entry[1],
                    ordinal = entry[1],
                    display_keymap = display_keymap,
                    exec_keymap = exec_keymap,
                }
            end
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                vim.notify(selection.display_keymap)
                --[[ vim.cmd("call feedkeys('".. selection.exec_keymap .. "')") ]]
            end)
            return true
        end,
    }):find()
end


return M
