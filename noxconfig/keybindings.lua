---------------------
---- KEYBINDINGS ----
---------------------

local programs = require('noxconfig.programs')

local super = "SUPER" --Using this as our main modifier
                      --to change this, adjust the mainMod function return
local shift = "SHIFT"
local ctrl  = "CTRL"
local alt   = "ALT"

local function mainMod(...)
    local parts = { super }
    for _, arg in ipairs({ ... }) do
        table.insert(parts, tostring(arg):upper())
    end
    return table.concat(parts, " + ")
end

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod("space"), hl.dsp.exec_cmd("fcitx5-remote -t")) --fcitx toggle
hl.bind(mainMod("Z"), hl.dsp.exec_cmd(programs.terminal))
-- hl.bind(mainMod("A"), hl.dsp.exec_cmd(programs.menu))
hl.bind(mainMod("A"), hl.dsp.global("faishell:toggleLauncher"))
hl.bind(mainMod(ctrl, shift, "G"), hl.dsp.global("faishell:toggleSettings"))
hl.bind(mainMod(ctrl, shift, "A"), hl.dsp.exec_cmd(programs.menuBackup))
hl.bind(mainMod("F"), hl.dsp.exec_cmd(programs.fileManager))
hl.bind(mainMod("E"), hl.dsp.exec_cmd(programs.emojiPicker))
hl.bind(mainMod("V"), hl.dsp.exec_cmd(programs.textToSpeech))
hl.bind(mainMod("P"), hl.dsp.exec_cmd(programs.colorPicker))
hl.bind(mainMod("S"), hl.dsp.exec_cmd(programs.snippetPicker))
hl.bind(mainMod("O"), hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(mainMod("Q"), hl.dsp.window.close())
hl.bind(mainMod("G"), hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod("M"), hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

hl.bind(mainMod(ctrl, shift, "M"), hl.dsp.window.move({ monitor = "DP-6", follow = true }))
hl.bind("CTRL + SHIFT + code:9", hl.dsp.exec_cmd("flatpak run io.missioncenter.MissionCenter"))
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region -z -c --clipboard-only"))
hl.bind(mainMod(shift, "S"), hl.dsp.exec_cmd("hyprshot -m region -z -c --clipboard-only"))
hl.bind(mainMod(shift, "A"), hl.dsp.exec_cmd("hyprshot -m output -z -c --clipboard-only"))

-- Move focus with mainMod + hjkl
hl.bind(mainMod("H"), hl.dsp.focus({ direction = "left"  }))
hl.bind(mainMod("L"), hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod("K"), hl.dsp.focus({ direction = "up"    }))
hl.bind(mainMod("J"), hl.dsp.focus({ direction = "down"  }))

-- Pass CTRL + F12 to OBS for replay buffer
hl.bind("CTRL + F12", hl.dsp.pass({ window = "class:^(com\\.obsproject\\.Studio)$" }))

-- vdesk setup
if hl.plugin.virtual_desktops ~= nil then
  for i = 1, 5 do
      hl.bind(mainMod(i), function()
          hl.plugin.virtual_desktops.vdesk(tostring(i))
      end, { description = "Switch to vdesk " .. i })
      hl.bind(mainMod(shift, i), function()
          hl.plugin.virtual_desktops.movetodesk(tostring(i))
      end, { description = "Move window to vdesk " .. i })
  end
end

-- mouse lmb/rmb dragging/resizing
-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Toggle keyboard repeat delay!!!
hl.bind("SUPER + ALT + R", function()
  local currentDelay = hl.get_config("input.repeat_delay")

  hl.notification.create({ text = "repeat_delay set to " .. currentDelay, timeout = 3000 })

  if currentDelay == 300 then
    hl.config({
      input = { repeat_delay = 500000 }
    })
  else
    hl.config({
      input = { repeat_delay = 300 }
    })
  end
end)

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Faishell binds
-- Debug
-- local debugSub = hl.on("input.keyboard.key", function(keycode, timeMs, state)
--     hl.notification.create({ text = "key " .. keycode .. " state " .. state, timeout = 1000 })
-- end)

-- ============================================================
-- Double-tap bare SUPER (no other key) to toggle overlay widgets
-- ============================================================
--
-- Reuses the SAME global-shortcut mechanism your Quickshell config
-- already listens for (GlobalShortcut{ appid: "faishell", name:
-- "toggleWidgets" }) -- no changes needed on the Quickshell side.
-- We're just triggering it from a gesture instead of a normal bind.

local DOUBLE_TAP_MS = 400  -- max gap between the two taps

-- Standard Linux evdev keycodes for the Super/Meta keys. These are
-- fixed by the kernel input-event-codes header, not by keyboard
-- layout, so this is safe across any layout/language setting.
local SUPER_KEYCODES = { [133] = true, [134] = true } -- KEY_LEFTMETA, KEY_RIGHTMETA

local superHeld = false
local superInterrupted = false
local pendingTap = false

local function triggerToggle()
    hl.dispatch(hl.dsp.global("faishell:toggleWidgets"))
end

local superKeyEventSubscription = hl.on("input.keyboard.key", function(keycode, timeMs, state)
    if SUPER_KEYCODES[keycode] then
        if state == 1 then
            -- Super pressed: start (or restart) tracking a clean hold.
            superHeld = true
            superInterrupted = false
        else
            -- Super released.
            superHeld = false

            if superInterrupted then
                return -- something else was pressed during this hold; ignore
            end

            if pendingTap then
                -- Second clean tap arrived within the window.
                pendingTap = false
                triggerToggle()
            else
                -- First clean tap. Arm a fresh oneshot timer that
                -- clears the pending flag if no second tap follows
                -- in time.
                pendingTap = true
                hl.timer(function()
                    pendingTap = false
                end, { timeout = DOUBLE_TAP_MS, type = "oneshot" })
            end
        end
    else
        -- Any other key pressed while Super is held marks this hold
        -- as "not a lone tap" -- this is what makes SUPER+Z (open
        -- terminal), SUPER+A (menu), etc. safely NOT count toward
        -- the double-tap gesture, without touching any of your
        -- existing binds above.
        if superHeld and state == 1 then
            superInterrupted = true
        end
    end
end)
