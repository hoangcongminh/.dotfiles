local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.font = wezterm.font_with_fallback({
	"JetBrainsMono Nerd Font",
	"JetBrains Mono",
})

config.font_size = 14
config.color_scheme = "Ubuntu"
config.window_background_opacity = 0.9
config.colors = {
	background = "#111111",
}

config.enable_tab_bar = true
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
config.show_tabs_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.show_tab_index_in_tab_bar = false
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.enable_scroll_bar = false
config.window_padding = { left = 0, right = 0, top = "0cell", bottom = 0 }

config.adjust_window_size_when_changing_font_size = false
config.front_end = "OpenGL"
config.native_macos_fullscreen_mode = false
config.window_close_confirmation = "NeverPrompt"

return config
