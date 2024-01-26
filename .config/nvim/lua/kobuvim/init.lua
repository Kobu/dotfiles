require("kobuvim.options")
local utils = require("kobuvim.utils")
local user_mappings = require("user.mappings")
local mappings_helper = require("kobuvim.mappings")
local _ = require("kobuvim.file_command_finder")

local notify = require("notify")
notify.setup({
    top_down = false
})

-- set notify.nvim as default notification function
vim.notify = notify

mappings_helper.set_mappings(user_mappings)
