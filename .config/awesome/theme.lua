---------------------------------------------
-- Awesome theme which follows xrdb config --
--   by Yauhen Kirylau                    --
---------------------------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local gdebug = require("gears.debug")
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

-- inherit default theme
local theme = dofile(themes_path .. "default/theme.lua")
-- load vector assets' generators for this theme

theme.font = "sans 8"

theme.useless_gap = dpi(6)
theme.border_width = dpi(2)
theme.border_color_normal = "#011826"
theme.border_color_active = "#D97E96"

-- Recolor Layout icons:
theme = theme_assets.recolor_layout(theme, theme.fg_normal)

-- Recolor titlebar icons:
--
local function darker(color_value, darker_n)
  local result = "#"
  for s in color_value:gmatch("[a-fA-F0-9][a-fA-F0-9]") do
    local bg_numeric_value = tonumber("0x" .. s) - darker_n
    if bg_numeric_value < 0 then
      bg_numeric_value = 0
    end
    if bg_numeric_value > 255 then
      bg_numeric_value = 255
    end
    result = result .. string.format("%2.2x", bg_numeric_value)
  end
  return result
end
theme = theme_assets.recolor_titlebar(theme, theme.fg_normal, "normal")
theme = theme_assets.recolor_titlebar(theme, darker(theme.fg_normal, -60), "normal", "hover")
theme = theme_assets.recolor_titlebar(theme, xrdb.color1, "normal", "press")
theme = theme_assets.recolor_titlebar(theme, theme.fg_focus, "focus")
theme = theme_assets.recolor_titlebar(theme, darker(theme.fg_focus, -60), "focus", "hover")
theme = theme_assets.recolor_titlebar(theme, xrdb.color1, "focus", "press")

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

theme.wallpaper = "/home/kobu/.config/awesome/wallpapers/nord.png"

-- Set different colors for urgent notifications.
rnotification.connect_signal("request::rules", function()
  rnotification.append_rule({
    rule = { urgency = "critical" },
    properties = { bg = "#ff0000", fg = "#ffffff" },
  })
end)

return theme
