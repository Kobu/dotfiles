local M = {}

function M.set_mappings(mappings)
  for mode, map_table in pairs(mappings) do
    for keymap, key_table in pairs(map_table) do
      vim.keymap.set(mode, keymap, key_table.cmd)
    end
  end
end

return M
