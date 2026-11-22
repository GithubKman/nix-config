---------------------
---- KEYBINDINGS ----
---------------------
require("scripts.mute")
hl.define_submap("passthru", function()
  hl.bind("Print + Escape", hl.dsp.submap("reset"))
--  hl.bind("Print", hl.dsp.exec_cmd(noctalia_ipc .. "bar-show"), { release = false })
  hl.bind("SUPER + Super_L", hl.dsp.exec_cmd(noctalia_ipc .. "bar-toggle"), { release = true })
end)
hl.bind("Print + Escape", hl.dsp.submap("passthru"))
local function conditional_dsp(mode, dsp)
	if current_mode == mode then
		hl.dispatch(dsp)
	end
end
conditional_dsp("normal", hl.dsp.exec_cmd("notify-send " .. mainMod))
hl.bind(mainMod .. " + ESCAPE", function() current_mode = "normal" end)

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Q", function() conditional_dsp("normal", hl.dsp.exec_cmd(terminal))end)
hl.bind(mainMod .. " + C", function() conditional_dsp("normal", hl.dsp.window.close())end)
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + SHIFT + M", function() conditional_dsp("normal", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))end)
-- hl.bind(mainMod .. " + M", function() conditional_dsp("normal", hl.dsp.exec_cmd("wpctl set-mute -p $(hyprctl activewindow -j | jq '.pid') toggle"))end)
hl.bind(mainMod .. " + M", mute)
hl.bind(mainMod .. " + E", function() conditional_dsp("normal", hl.dsp.exec_cmd(fileManager))end)
hl.bind(mainMod .. " + V", function() conditional_dsp("normal", hl.dsp.window.float({ action = "toggle" }))end)
--hl.bind(mainMod .. " + SPACE", function() conditional_dsp("normal", hl.dsp.exec_cmd(menu))end)
hl.bind(mainMod .. " + P", function() conditional_dsp("normal", hl.dsp.window.pseudo())end)
hl.bind(mainMod .. " + B", function() conditional_dsp("normal", hl.dsp.layout("togglesplit"))end)    -- dwindle only
hl.bind(mainMod .. " + F", function() conditional_dsp("normal", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))end)    -- dwindle only
--hl.bind(mainMod .. " + S", function() 
--	local active_window = hl.get_active_window()
--	hl.dsp.group.toggle()
--        hl.dsp.focus({ active_window })
--    end )


hl.bind("XF86Launch5",  hl.dsp.exec_cmd("systemctl suspend"))
-- Noctalia --
-- Core binds
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(noctalia_ipc .. "panel-toggle launcher"))
hl.bind(mainMod .. " + i", hl.dsp.exec_cmd(noctalia_ipc .. "settings-toggle"))
hl.bind("ALT + Tab", hl.dsp.exec_cmd(noctalia_ipc .. "window-switcher"))

-- Media keys
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd(noctalia_ipc .. "volume-up"))
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd(noctalia_ipc .. "volume-down"))
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd(noctalia_ipc .. "volume-mute"))
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd(noctalia_ipc .. "mic-mute"))
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(noctalia_ipc .. "brightness-up"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(noctalia_ipc .. "brightness-down"))

-- Noctalia Settings
hl.window_rule({
    match = { class = "dev.noctalia.Noctalia" },
    float = true,
    size = { 1080, 920 },
})

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left", true }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right", true }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up", true }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down", true }))

hl.bind(mainMod .. " + bracketleft", hl.dsp.focus({ monitor = "-1" }))
hl.bind(mainMod .. " + bracketright", hl.dsp.focus({ monitor = "+1" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]


for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = "r~" .. i, on_current_monitor = true}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = "r~" .. i, on_current_monitor = true }))
end
-- Next and previous workspace on the active monitor
hl.bind(mainMod .. " + comma",  hl.dsp.focus({ workspace = "m-1"}))
hl.bind(mainMod .. " + period", hl.dsp.focus({ workspace = "m+1"}))

-- Move active window to next/prev workspace on the active monitor
hl.bind(mainMod .. " + SHIFT + comma",  hl.dsp.window.move({ workspace = "m-1", true}))
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.window.move({ workspace = "m+1", true}))


-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
-- hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+"), { locked = true, repeating = true })
-- hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"),      { locked = true, repeating = true })
-- hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
-- hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
-- hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
-- hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
