local wezterm = require("wezterm")
local config = {}
config.color_scheme = "Banana Blueberry"
config.font = wezterm.font("JetBrains Mono")
config.default_cwd = os.getenv("HOME") .. "/github/saral"
config.font_size = 14

-- config.leader = { key = " ", mods = "CTRL" }
-- config.keys = {
-- 	{ key = " ", mods = "CTRL", action = wezterm.action.SendKey({ key = " ", mods = "CTRL" }) },
--
-- 	-- Leader-based bindings
-- 	{ key = "c", mods = "LEADER", action = wezterm.action.SpawnTab("DefaultDomain") }, -- New tab
-- 	{ key = "w", mods = "LEADER", action = wezterm.action.CloseCurrentTab({ confirm = true }) }, -- Close tab
-- 	{ key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") }, -- Move to left pane
-- 	{ key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") }, -- Move to right pane
-- 	{ key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") }, -- Move to down pane
-- 	{ key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") }, -- Move to up pane
-- 	{ key = "v", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) }, -- Horizontal split
-- 	{ key = "s", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) }, -- Vertical split
-- 	{ key = "z", mods = "LEADER", action = wezterm.action.TogglePaneZoomState }, -- Toggle pane zoom
-- 	{ key = "x", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = true }) }, -- Close pane,
-- }

config.enable_scroll_bar = true
return config
