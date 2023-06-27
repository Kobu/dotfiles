function load_plugin(plugin_name)
  local status_ok, plugin = pcall(require, plugin_name)
  if not status_ok then
    vim.notify("Failed to load plugin: " .. plugin_name, vim.log.levels.ERROR, { title = "Error loading a plugin!" })
    return false
  end
  return plugin
end

-- message: string (reasoning behind deprecation)
-- keymap: string (new keymap to be used instead)
-- command: function (the original function ran on this keymap)
function outdated_keymap(opts)
  return function()
    vim.notify(
      {
        opts.message,
        opts.keymap and ("Use '" .. opts.keymap .. "' instead!") or nil,
      },
      vim.log.levels.WARN,
      {
        title = "This keymap is deprecated!!",
      }
    )
    opts.command()
  end
end
