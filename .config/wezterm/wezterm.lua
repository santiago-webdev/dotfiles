local wezterm = require('wezterm')

return {
    -- Fonts
    -- font = wezterm.font('Operator Mono'),
    -- font = wezterm.font('Cartograph CF'),
    -- font = wezterm.font('JetBrains Mono'),
    font = wezterm.font('Iosevka Term'),
    font_size = 16.6,
    line_height = 0.98,

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

    colors = {

        indexed = { [136] = '#af8700' }, -- Arbitrary colors of the palette in the range from 16 to 255

        -- Rosé Pine dark, ansi colors are darken colors from the main palette
        foreground = '#716D8B', -- The default text color
        background = '#191724', -- The default background color
        cursor_bg = '#555169',
        cursor_fg = '#e0def4',
        cursor_border = 'orange',
        selection_fg = 'black', -- the foreground color of selected text
        selection_bg = 'orange', -- the background color of selected text
        split = '#3f3c53', -- The color of the split lines between panes
        tab_bar = {
            background = '#232136',
            active_tab = {
                bg_color = '#2a273f',
                fg_color = '#e0def4',
            },
            inactive_tab = {
                bg_color = '#191724',
                fg_color = '#6e6a86',
            },
            new_tab = {
                bg_color = '#232136',
                fg_color = '#6e6a86',
            },
            new_tab_hover = {
                bg_color = '#2a273f',
                fg_color = '#6e6a86',
                italic = true,
            },
        },
        ansi = {
            '#26233a',
            '#b4637a',
            '#286983',
            '#d4a76c',
            '#9ccfd8',
            '#c4a7e7',
            '#d7827e',
            '#e0def4',
        },
        brights = {
            '#3b425b',
            '#eb6f92',
            '#31748f',
            '#f6c177',
            '#9ccfd8',
            '#c4a7e7',
            '#d7827e',
            '#e0def4',
        },

        -- -- Rosé Pine moon
        -- foreground = '#908caa', -- The default text color
        -- background = '#232136', -- The default background color
        -- cursor_bg = '#56526e',
        -- cursor_fg = '#e0def4',
        -- selection_fg = 'black', -- the foreground color of selected text
        -- selection_bg = '#3e8fb0', -- the background color of selected text
        -- split = '#2a273f', -- The color of the split lines between panes
        -- tab_bar = {
        --     background = '#232136',
        --     active_tab = {
        --         bg_color = '#2a273f',
        --         fg_color = '#e0def4',
        --     },
        --     inactive_tab = {
        --         bg_color = '#191724',
        --         fg_color = '#6e6a86',
        --     },
        --     new_tab = {
        --         bg_color = '#232136',
        --         fg_color = '#6e6a86',
        --     },
        --     new_tab_hover = {
        --         bg_color = '#2a273f',
        --         fg_color = '#6e6a86',
        --         italic = true,
        --     },
        -- },
        -- ansi = {
        --     '#2a273f',
        --     '#b4637a',
        --     '#286983',
        --     '#d4a76c',
        --     '#9ccfd8',
        --     '#c4a7e7',
        --     '#d7827e',
        --     '#e0def4',
        -- },
        -- brights = {
        --     '#575279',
        --     '#eb6f92',
        --     '#31748f',
        --     '#f6c177',
        --     '#9ccfd8',
        --     '#c4a7e7',
        --     '#d7827e',
        --     '#e0def4',
        -- },

    },
    force_reverse_video_cursor = true,
    window_close_confirmation = 'NeverPrompt',
    exit_behavior = 'Close',
    skip_close_confirmation_for_processes_named = { 'zsh', 'nvim' },
    check_for_updates = false,
}
