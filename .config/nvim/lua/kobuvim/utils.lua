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

function vim.getVisualSelection()
    vim.cmd('noau normal! "vy"')
    local text = vim.fn.getreg('v')
    vim.fn.setreg('v', {})

    text = string.gsub(text, "\n", "")
    if #text > 0 then
        return text
    else
        return ''
    end
end

local function parse_command_output(output)
    local list = {}

    -- check if output is a string
    if type(output) ~= 'string' then
        vim.notify('command did not return a string')
        return
    end

    for token in string.gmatch(output, "[^%c]+") do
        table.insert(list, token)
    end

    return list
end

local function execute_command(command, opts)
    local handle
    if (opts.ignore_stderr == true) then
        handle = io.popen("( " .. command .. " ) 2>/dev/null")
    else
        handle = io.popen(command)
    end


    if (handle == nil) then
        print('could not run specified command:' .. command)
        return
    end

    local output = handle:read("*a")

    handle:close()

    return output
end

function vim.run_command(command, opts)
    return parse_command_output(execute_command(command, opts))
end
