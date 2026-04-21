local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- UTILITY SETTINGS

-- Startup size
-- config.initial_cols = 120
-- config.initial_rows = 40

-- GPU-accelerated rasterization
config.front_end = "WebGpu"

-- Start shell depending on OS
if wezterm.target_triple:find("windows") then
	config.default_prog = { "pwsh.exe" }
else
	config.default_prog = { "/usr/bin/fish", "-l" }
end

config.use_dead_keys = false
config.scrollback_lines = 5000
config.adjust_window_size_when_changing_font_size = false
config.hide_tab_bar_if_only_one_tab = true

-- APPEARANCE SETTINGS

-- Font
config.font = wezterm.font_with_fallback({
	"JuliaMono Nerd Font",
})
config.font_size = 15

config.color_schemes = config.color_schemes or {}

config.color_scheme_dirs = { "./colors/" }

-- Themes for switching
local themes = {
	dark = {
		color_scheme = "Melange Dark",
		window_background_opacity = 0.99,
		text_background_opacity = 0.99,
	},
	light = {
		color_scheme = "Paper (Gogh)",
		window_background_opacity = 0.99,
		text_background_opacity = 0.99,
	},
}

-- Use dark theme by default
local current_theme = "dark"
for k, v in pairs(themes[current_theme]) do
	config[k] = v
end

-- config.color_scheme = "Paper (Gogh)"

config.hide_tab_bar_if_only_one_tab = false
config.force_reverse_video_cursor = true

-- BINDINGS

local act = wezterm.action
config.keys = {
	{
		key = "\\",
		mods = "CTRL|ALT",
		action = wezterm.action.SplitHorizontal({
			domain = "CurrentPaneDomain",
		}),
	},
	{ key = "-", mods = "CTRL|ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "h", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "k", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "j", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "q", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
	{ key = "LeftArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
	{ key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
	{ key = "UpArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
	{ key = "DownArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },

	-- Theme toggle: Ctrl+Alt+t
	{
		key = "t",
		mods = "CTRL|ALT",
		action = wezterm.action_callback(function(win, pane)
			current_theme = (current_theme == "dark") and "light" or "dark"
			local overrides = win:get_config_overrides() or {}
			for k, v in pairs(themes[current_theme]) do
				overrides[k] = v
			end
			win:set_config_overrides(overrides)

			-- Send command to Fish to toggle its theme
			pane:send_text("toggle_theme\n")
		end),
	},
}

return config
