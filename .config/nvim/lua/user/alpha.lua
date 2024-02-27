local alpha = load_plugin("alpha")
if not alpha then
  return
end

local dashboard = load_plugin("alpha.themes.dashboard")
if not dashboard then
  return
end

dashboard.section.header.val = {
  [[                               __                ]],
  [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
  [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
  [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
  [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
  [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}

dashboard.section.buttons.val = {
  dashboard.button("f", "拾 FI Muni", ":cd ~/fimuni | :NvimTreeFocus<CR>"),
  dashboard.button("b", "  Edit .bashrc", ":e ~/.bashrc <CR>"),
  dashboard.button("d", "  Dotfiles", ":cd ~/.config | :NvimTreeFocus<CR>"),
  dashboard.button(
    "c",
    "  Configuration",
    ":e ~/coding/dotfiles/.config/nvim/init.lua |:cd ~/coding/dotfiles/.config/nvim/ <CR>"
  ),
  dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
