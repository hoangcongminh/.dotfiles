local wezterm = require("wezterm")

local config = {
	font = wezterm.font_with_fallback({
		"JetBrainsMono Nerd Font",
		"JetBrains Mono",
	}),
	font_size = 13,
	window_background_opacity = 0.9,
	macos_window_background_blur = 10,
	color_scheme = "rose-pine-moon",
	colors = {
		background = "black",
	},

	adjust_window_size_when_changing_font_size = false,
	enable_tab_bar = false,
	native_macos_fullscreen_mode = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
}

wezterm.on("gui-startup", function()
	local _, _, window = wezterm.mux.spawn_window({})
	window:gui_window():maximize()
end)

return config
