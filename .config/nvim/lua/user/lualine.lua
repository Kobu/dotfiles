local lualine = load_plugin("lualine")
if not lualine then
  return
end

local function lines()
  return vim.api.nvim_buf_line_count(0) .. " lines"
end

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "moonlight",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = { "NvimTree" },
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 0,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = {},
    lualine_x = { "filetype" },
    lualine_y = { lines },
    lualine_z = { "diagnostics" },
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})
