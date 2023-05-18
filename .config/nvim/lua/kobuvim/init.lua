local utils = require("kobuvim.utils")
local user_mappings = require("user.mappings")
local mappings_helper = require("kobuvim.mappings")

-- set notify.nvim as default notification function
vim.notify = require("notify")

mappings_helper.set_mappings(user_mappings)
