-- Pull in the wezterm API
local wezterm = require("wezterm")
local projects = require("projects")
-- This will hold the configuration.
local config = wezterm.config_builder()
-- Actions
local action = wezterm.action
-- Multiplexer
local mux = wezterm.mux
-- Logs
local log = wezterm.log_info

-- Settings
config.default_prog = { "/bin/zsh", "-l" }
config.scrollback_lines = 3500

-- FONT
config.font_size = 12
config.font = wezterm.font("JetBrainsMono NF")
config.colors = {
  cursor_bg = "white",
  cursor_border = "white",
}

-- APPEARANCE
config.window_decorations = "RESIZE"
config.color_scheme = "Catppuccin Mocha"
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_background_opacity = 0.9
-- MENU
config.launch_menu = {
  {
    args = { "top" },
  },
  {
    label = "Bash",
    args = { "bash", "-l" },
  },
}

-- KEYMAPS
config.leader = { key = "f", mods = "ALT", timeout_milliseconds = 10000 }
config.keys = {
  { key = "c", mods = "LEADER", action = action.SpawnTab("CurrentPaneDomain") },
  { key = "q", mods = "LEADER", action = action.CloseCurrentTab({ confirm = false }) },
  { key = "1", mods = "ALT",    action = action.ActivateTab(0) },
  { key = "2", mods = "ALT",    action = action.ActivateTab(1) },
  { key = "3", mods = "ALT",    action = action.ActivateTab(2) },
  { key = "4", mods = "ALT",    action = action.ActivateTab(3) },
  { key = "5", mods = "ALT",    action = action.ActivateTab(4) },
  { key = "6", mods = "ALT",    action = action.ActivateTab(5) },
  { key = "7", mods = "ALT",    action = action.ActivateTab(6) },
  { key = "8", mods = "ALT",    action = action.ActivateTab(7) },
  { key = "9", mods = "ALT",    action = action.ActivateTab(8) },
  { key = "0", mods = "ALT",    action = action.ActivateTab(9) },
  { key = "u", mods = "ALT",    action = action.ActivateTabRelative(-1) },
  { key = "i", mods = "ALT",    action = action.ActivateTabRelative(1) },
  { key = "w", mods = "ALT",    action = action.ActivateLastTab },
  { key = "l", mods = "ALT",    action = action.ShowLauncher },
  { key = "c", mods = "ALT",    action = action.SwitchToWorkspace({ name = "code" }) },
  { key = "d", mods = "ALT",    action = action.SwitchToWorkspace({ name = "debug" }) },
  {
    key = "p",
    mods = "ALT",
    action = action.InputSelector({
      action = wezterm.action_callback(function(window, pane, id, label)
        if not id and not label then
          log("cancelled")
        else
          local windows = mux.all_windows()
          for _, w in ipairs(windows) do
            local name = w:get_workspace()
            if name == "code" then
              local tabs = w:tabs()
              local tab_found = false
              for _, t in ipairs(tabs) do
                if t:get_title() == label then
                  t:activate()
                  tab_found = true
                  break
                end
              end
              if not tab_found then
                log(id)
                local tab = w:spawn_tab({
                  args = {
                    "zsh",
                    "-c",
                    "cd " .. id .. " ; nvim",
                  },
                })
                tab:set_title(label)
              end
              break
            end
          end
          window:perform_action(action.SwitchToWorkspace({ name = "code" }), pane)
          -- local mux_window = mux.get_window()
        end
      end),
      title = "Projects",
      fuzzy = true,
      fuzzy_description = "Project:",
      choices = projects.choices,
    }),
  },
}

-- and finally, return the configuration to wezterm
return config
