local scan = require("plenary.scandir")
local transform_mod = require("telescope.actions.mt").transform_mod

local action_set = require("telescope.actions.set")
local make_entry = require("telescope.make_entry")

local conf = require("telescope.config").values

local telescope = load_plugin("telescope")
if not telescope then
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

local pickers = load_plugin("telescope.pickers")
if not pickers then
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

local hot_keys = load_plugin("user.hot-keys")
if not hot_keys then
  return
end

telescope.load_extension("recent_files")
vim.keymap.set("n", "<leader>rf", function()
  telescope.extensions.recent_files.pick()
end, {})

local live_grep_filters = {
  ---@type nil|string
  extension = nil,
  ---@type nil|string[]
  directories = nil,
}

vim.keymap.set("v", "<leader>aa", function()
  local text = vim.getVisualSelection()
  builtin.find_files({ default_text = text })
end, {})
vim.keymap.set("v", "<leader>lg", function()
  local text = vim.getVisualSelection()
  builtin.live_grep({ default_text = text })
end, {})

vim.keymap.set("n", "<leader>aa", builtin.find_files, {})
vim.keymap.set("n", "<leader>lg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>ht", builtin.help_tags, {})
vim.keymap.set("n", "<leader>km", builtin.keymaps, {})
vim.keymap.set("n", "<leader>hk", function()
  hot_keys.picker(require("telescope.themes").get_dropdown({}))
end, {})
vim.keymap.set("n", "gs", builtin.git_status, {})
vim.keymap.set("n", "gb", builtin.git_branches, {})
vim.keymap.set("n", "si", builtin.lsp_implementations, {})
vim.keymap.set("n", "sd", builtin.lsp_definitions, {})
vim.keymap.set("n", "ghb", function()
  builtin.git_bcommits({
    git_command = { "git", "log", "--format=%C(bold blue)%h %C(211)[Date: %as] %C(magenta)[%an] %Creset%s" },
  })
end, {})
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
vim.keymap.set("n", "sr", function()
  builtin.lsp_references({ jump_type = "never" })
end, {})
vim.keymap.set("n", "e", builtin.resume, {})
vim.keymap.set("n", "<leader>td", ":TodoTelescope<CR>", {})

local function doDiff()
  -- Open in diffview
  local selected_entry = action_state.get_selected_entry()
  local value = selected_entry.value
  -- close Telescope window properly prior to switching windows
  vim.api.nvim_win_close(0, true)
  vim.cmd("stopinsert")
  vim.schedule(function()
    vim.cmd(("DiffviewClose"):format(value))
    vim.cmd(("DiffviewOpen %s^!"):format(value))
  end)
end

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

local function doRebase(bufnr)
  local selection = action_state.get_selected_entry()
  local sha = selection.value
  actions.smart_send_to_qflist(bufnr)
  vim.cmd("Git rebase -i " .. sha .. "^")
end

---Run `live_grep` with the active filters (extension and folders)
local function run_live_grep(current_input)
  -- TODO: Resume old one with same options somehow
  require("telescope.builtin").live_grep({
    additional_args = live_grep_filters.extension and function()
      return { "-g", "*." .. live_grep_filters.extension }
    end,
    search_dirs = live_grep_filters.directories,
    default_text = current_input,
  })
end

local os_sep = "/"

local my_actions = transform_mod({
  ---Ask for a file extension and open a new `live_grep` filtering by it
  set_extension = function(prompt_bufnr)
    local current_picker = action_state.get_current_picker(prompt_bufnr)
    local current_input = action_state.get_current_line()

    vim.ui.input({ prompt = "*." }, function(input)
      if input == nil then
        return
      end

      live_grep_filters.extension = input

      actions._close(prompt_bufnr, current_picker.initial_mode == "insert")
      run_live_grep(current_input)
    end)
  end,
  ---Ask the user for a folder and olen a new `live_grep` filtering by it
  set_folders = function(prompt_bufnr)
    local current_picker = action_state.get_current_picker(prompt_bufnr)
    local current_input = action_state.get_current_line()

    local data = {}
    scan.scan_dir(vim.loop.cwd(), {
      hidden = true,
      only_dirs = true,
      respect_gitignore = true,
      on_insert = function(entry)
        table.insert(data, entry .. os_sep)
      end,
    })
    table.insert(data, 1, "." .. os_sep)

    actions._close(prompt_bufnr, current_picker.initial_mode == "insert")
    pickers
      .new({}, {
        prompt_title = "Folders for Live Grep",
        finder = finders.new_table({ results = data, entry_maker = make_entry.gen_from_file({}) }),
        previewer = conf.file_previewer({}),
        sorter = conf.file_sorter({}),
        attach_mappings = function(prompt_bufnr)
          action_set.select:replace(function()
            local current_picker = action_state.get_current_picker(prompt_bufnr)

            local dirs = {}
            local selections = current_picker:get_multi_selection()
            if vim.tbl_isempty(selections) then
              table.insert(dirs, action_state.get_selected_entry().value)
            else
              for _, selection in ipairs(selections) do
                table.insert(dirs, selection.value)
              end
            end
            live_grep_filters.directories = dirs

            actions.close(prompt_bufnr)
            run_live_grep(current_input)
          end)
          return true
        end,
      })
      :find()
  end,
})

telescope.setup({
  extensions = {
    recent_files = {
      only_cwd = true,
      -- This extension's options, see below.
    },
  },
  defaults = {
    layout_strategy = "vertical",
    layout_config = { height = 0.95, width = 0.95, preview_height = 0.7 },
    path_display = { "truncate" },
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-q>"] = actions.close,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-h>"] = actions.preview_scrolling_left,
        ["<C-l>"] = actions.preview_scrolling_right,
      },
    },
  },
  pickers = {
    live_grep = {
      mappings = {
        i = {
          ["<C-p>"] = my_actions.set_folders,
        },
      },
    },
    git_bcommits = {
      mappings = {
        i = {
          ["S"] = getSha,
          ["R"] = doRebase,
          ["<cr>"] = doDiff,
        },
      },
    },
    git_commits = {
      mappings = {
        i = {
          ["S"] = getSha,
          ["R"] = doRebase,
          ["<cr>"] = doDiff,
        },
      },
    },
  },
})
