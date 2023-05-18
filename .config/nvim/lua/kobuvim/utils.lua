function load_plugin(plugin_name)
  local status_ok, plugin = pcall(require, plugin_name)
  if not status_ok then
    vim.notify("Failed to load plugin: " .. plugin_name, vim.log.levels.ERROR, { title = "Error loading a plugin!" })
    return false
  end
  return plugin
end
