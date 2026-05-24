local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

config.default_prog = { 'C:\\msys64\\usr\\bin\\zsh.exe', '--login', '-i' }
config.set_environment_variables = {
    MSYS = 'winsymlinks:nativestrict',
    MSYS2_PATH_TYPE = 'inherit',
    HOME = os.getenv('USERPROFILE'),
    MSYSTEM = 'UCRT64',
    CHERE_INVOKING = '1',
}

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = {
    { key = 'h', mods = 'LEADER',       action = act.ActivatePaneDirection('Left') },
    { key = 'j', mods = 'LEADER',       action = act.ActivatePaneDirection('Down') },
    { key = 'k', mods = 'LEADER',       action = act.ActivatePaneDirection('Up') },
    { key = 'l', mods = 'LEADER',       action = act.ActivatePaneDirection('Right') },
    { key = 'a', mods = 'LEADER|CTRL',  action = act.SendKey { key = 'a', mods = 'CTRL' } },
    { key = '|', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    {
        key = '-',
        mods = 'LEADER',
        action = act.SplitPane {
            direction = 'Down',
            size = { Percent = 20 },
        },
    },
    { key = 'm', mods = 'LEADER',       action = act.TogglePaneZoomState },
    { key = 'r', mods = 'LEADER',       action = act.ReloadConfiguration },
    { key = 'h', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize({ 'Left', 5 }) },
    { key = 'j', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize({ 'Down', 5 }) },
    { key = 'k', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize({ 'Up', 5 }) },
    { key = 'l', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize({ 'Right', 5 }) },
    { key = 'c', mods = 'LEADER',       action = act.SpawnTab('CurrentPaneDomain') },
    { key = '1', mods = 'LEADER',       action = act.ActivateTab(0) },
    { key = '2', mods = 'LEADER',       action = act.ActivateTab(1) },
    { key = '3', mods = 'LEADER',       action = act.ActivateTab(2) },
    { key = '4', mods = 'LEADER',       action = act.ActivateTab(3) },
    { key = '5', mods = 'LEADER',       action = act.ActivateTab(4) },
    { key = '6', mods = 'LEADER',       action = act.ActivateTab(5) },
    { key = '7', mods = 'LEADER',       action = act.ActivateTab(6) },
    { key = '8', mods = 'LEADER',       action = act.ActivateTab(7) },
    { key = '9', mods = 'LEADER',       action = act.ActivateTab(8) },
    { key = '[', mods = 'LEADER',       action = act.ActivateCopyMode },
}

config.font = wezterm.font("Iosevka NFM", { weight = "Regular", style = "Normal" })
config.font_size = 12.5

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.enable_tab_bar = true

config.colors = {
    foreground = "#E0CCAE",
    background = "#0f0908",
    cursor_bg = "#E0CCAE",
    cursor_border = "#E0CCAE",
    cursor_fg = "#0f0908",
    selection_bg = "#6b442f",
    selection_fg = "#E0CCAE",
    split = "#d47d49",
    compose_cursor = "#ff9e64",
    scrollbar_thumb = "#241816",
    ansi = { "#0c0706", "#bf472c", "#a4896f", "#f2a766", "#d47d49", "#8a4b53", "#a67458", "#F2A766" },
    brights = { "#392D2B", "#bf472c", "#a4896f", "#f2a766", "#d47d49", "#8a4b53", "#a67458", "#E0CCAE" },
    tab_bar = {
        inactive_tab_edge = "#1f1311",
        background = "#0f0908",
        active_tab = {
            fg_color = "#1f1311",
            bg_color = "#d47d49",
        },
        inactive_tab = {
            fg_color = "#66292F",
            bg_color = "#241816",
        },
        inactive_tab_hover = {
            fg_color = "#d47d49",
            bg_color = "#241816",
        },
        new_tab = {
            fg_color = "#d47d49",
            bg_color = "#0f0908",
        },
        new_tab_hover = {
            fg_color = "#d47d49",
            bg_color = "#0f0908",
            intensity = "Bold",
        },
    },
}
wezterm.on("update-right-status", function(window, pane)
    local leader = ""
    if window:leader_active() then
        leader = "  WAIT  "
    end

    window:set_right_status(wezterm.format({
        { Foreground = { Color = "#d47d49" } },
        { Background = { Color = "#1f1311" } },
        { Text = leader },
        { Foreground = { Color = "#6B4035" } },
        { Text = "" },
        { Background = { Color = "#6B4035" } },
        { Foreground = { Color = "#d47d49" } },
        { Text = " " .. wezterm.strftime("%Y-%m-%d %I:%M %p") .. " " },
        { Foreground = { Color = "#d47d49" } },
        { Background = { Color = "#d47d49" } },
        { Foreground = { Color = "#0c0706" } },
        { Text = "" },
        { Text = " " .. wezterm.hostname() .. " " },
    }))
end)

config.window_padding = { left = 15, right = 15, top = 15, bottom = 10 }
config.window_decorations = "TITLE | RESIZE"

return config
