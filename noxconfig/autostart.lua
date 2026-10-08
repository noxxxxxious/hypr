-------------------
---- AUTOSTART ----
-------------------
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

local programs = require('noxconfig.programs')

hl.on("hyprland.start", function ()
  hl.exec_cmd(programs.terminal)
  -- hl.exec_cmd(programs.wallpaperManager)
  hl.exec_cmd(programs.taskbar)
  hl.exec_cmd('systemctl --user start hyprpolkitagent')
  hl.exec_cmd('hyprpm reload -n')
  hl.exec_cmd('wl-paste --type text --watch cliphist store') -- clipboard history, text data
  hl.exec_cmd('wl-paste --type image --watch cliphist store') -- clipboard-history, image data
  hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')   -- for GTK4 apps
end)
