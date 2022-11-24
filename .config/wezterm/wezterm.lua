local wezterm = require('wezterm')

return {
   -- Fonts
   -- font = wezterm.font('Operator Mono'),
   -- font = wezterm.font('Cartograph CF'),
   -- font = wezterm.font('JetBrains Mono'),
   font = wezterm.font('Iosevka Term'),
   -- font = wezterm.font('LigaSFMono Nerd Font'),
   font_size = 17,
   -- line_height = 0.98,
   -- line_height = 1.02,

   -- custom_block_glyphs = false,

   -- foreground_text_hsb = {
   --     hue = 1.0,
   --     saturation = 1.0,
   --     brightness = 1.05,
   -- },
   window_padding = {
      top = 0,
      left = 0,
      right = 0,
      bottom = 0,
   },

   -- window_background_opacity = 0.9,
   -- text_background_opacity = 0.9,

   use_dead_keys = true, -- For áéíóú
   enable_wayland = true,

   -- Tab bar
   hide_tab_bar_if_only_one_tab = true,
   enable_tab_bar = true,
   use_fancy_tab_bar = true,
   tab_max_width = 33,
   tab_bar_at_bottom = true,

   colors = require('jetjbp'),
   -- colors = {
   --    indexed = { [136] = '#af8700' }, -- Arbitrary colors of the palette in the range from 16 to 255
   --    cursor_bg = '#555169',
   --    cursor_fg = '#e0def4',
   --    cursor_border = 'orange',
   --    selection_fg = 'black', -- the foreground color of selected text
   --    selection_bg = 'orange', -- the background color of selected text
   --    split = '#3f3c53', -- The color of the split lines between panes
   --    foreground = '#C6D0F5', -- The default text color
   --    background = '#191724', -- The default background color
   --    tab_bar = {
   --       background = '#232136',
   --       active_tab = {
   --          bg_color = '#2a273f',
   --          fg_color = '#e0def4',
   --       },
   --       inactive_tab = {
   --          bg_color = '#191724',
   --          fg_color = '#6e6a86',
   --       },
   --       new_tab = {
   --          bg_color = '#232136',
   --          fg_color = '#6e6a86',
   --       },
   --       new_tab_hover = {
   --          bg_color = '#2a273f',
   --          fg_color = '#6e6a86',
   --          italic = true,
   --       },
   --    },
   --    ansi = {
   --       '#3D3A56',
   --       '#EB6F92',
   --       '#559A8B',
   --       '#FF9E64',
   --       '#4682B4',
   --       '#9D86B9',
   --       '#d7827e',
   --       '#8689B9',
   --    },
   --    brights = {
   --       '#534F79',
   --       '#EBA0AC',
   --       '#93C88E',
   --       '#FAB387',
   --       '#87B0F9',
   --       '#BB9AF7',
   --       '#d7827e',
   --       '#C6D0F5',
   --    },
   -- },
   force_reverse_video_cursor = true,
   window_close_confirmation = 'NeverPrompt',
   exit_behavior = 'Close',
   skip_close_confirmation_for_processes_named = { 'zsh', 'nvim' },
   check_for_updates = false,
}
