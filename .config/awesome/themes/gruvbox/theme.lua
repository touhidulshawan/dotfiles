local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi
local os = os

--colors
local black = "#282828"
local black2 = "#504945"
local red = "#cc241d"
local green = "#b8bb26"
local yellow = "#d79921"
local blue = "#458588"
local purple = "#b16286"
local aqua = "#689d6a"
local orange = "#d65d0e"
local white = "#ebdbb2"

local theme = {}
theme.confdir = os.getenv("HOME") .. "/.config/awesome/themes/gruvbox"
theme.wallpaper = theme.confdir .. "/arch.png"
theme.font = "JetBrainsMono NF SemiBold 11"
theme.taglist_font = "Symbols Nerd Font Mono 10"

theme.bg_normal = black
theme.bg_focus = green
theme.bg_urgent = red
theme.fg_normal = white
theme.fg_focus = black
theme.fg_urgent = black
theme.bg_systray = black
theme.border_width = 2
theme.border_normal = black2
theme.border_focus = purple
theme.border_marked = aqua
theme.taglist_squares_sel = theme.confdir .. "/taglist/linefw.png"
theme.taglist_squares_unsel = theme.confdir .. "/taglist/linew.png"
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon = true
theme.useless_gap = dpi(4)

local markup = lain.util.markup

os.setlocale(os.getenv("LANG"))


-- Widgets

local mytextclock =
    wibox.widget.textclock(markup(blue, " 󱑆 " .. "%I:%M:%p") .. markup(orange, "  " .. "%d-%b-%a "))
mytextclock.font = theme.font

-- calender
theme.cal = lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
        font = theme.font,
        fg = yellow,
        bg = black,
    },
})

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_batt)
local bat = lain.widget.bat({
    settings = function()
        local perc = "  " .. bat_now.perc ~= "N/A" and "  " .. bat_now.perc .. "%" or "  " .. bat_now.perc

        if bat_now.ac_status == 1 then
            perc = perc .. " "
        end

        widget:set_markup(markup.fontfg(theme.font, purple, perc))
    end,
})

-- ALSA volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == "off" then
            volume_now.level = volume_now.level .. "M"
        end

        widget:set_markup(markup.fontfg(theme.font, green, " 󰗅 " .. volume_now.level .. "% "))
    end
})
-- MPD
local mpdicon = wibox.widget.imagebox()
theme.mpd = lain.widget.mpd({
    settings = function()
        mpd_notification_preset = {
            text = string.format("%s [%s] - %s", mpd_now.artist, mpd_now.album, mpd_now.title),
        }

        if mpd_now.state == "play" then
            artist = mpd_now.artist .. " ⟫ "
            title = mpd_now.title .. " "
            mpdicon:set_image(theme.widget_note_on)
        elseif mpd_now.state == "pause" then
            artist = "mpd "
            title = "paused "
        else
            artist = ""
            title = ""
            --mpdicon:set_image() -- not working in 4.0
            mpdicon._private.image = nil
            mpdicon:emit_signal("widget::redraw_needed")
            mpdicon:emit_signal("widget::layout_changed")
        end
        widget:set_markup(markup.fontfg(theme.font, aqua, title))
    end,
})

-- Network widget

network_widget = wibox.widget {
    widget = wibox.widget.textbox,
    font = theme.font,
    valign = "center",
    align = "center"
}

-- Set the widget text
function update_network_widget()
    local ip_address = get_ip_address()
    if ip_address ~= "0" then
        network_widget:set_markup("<span color='#458588'> </span><span color='#458588'>" .. ip_address .. "</span>")
    end
end

-- Get the current IP address
function get_ip_address()
    local f = io.popen("ip addr show dev tun0 | grep 'inet ' | awk '{print $2}'")
    local ip_address = f:read("*l")
    f:close()
    return ip_address or "0"
end

-- Update the widget every 5 seconds
awful.widget.watch("bash -c 'ip addr show dev eno1 | grep \"inet \" | awk \"{print $2}\"'", 5, function(widget, stdout)
    update_network_widget()
end)

-- RAM widget

ram_widget = wibox.widget {
    font = theme.font,
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox,
}

-- Function to update the RAM widget
function update_ram_widget()
    local used = get_used_ram()
    local formatted_used

    if used >= 1024 then
        formatted_used = string.format("%.2fGB", used / 1024)
    else
        formatted_used = string.format("%dMB", used)
    end

    ram_widget:set_markup(string.format("<span color='#d79921'> 󰍛 </span><span color='#d79921'>%s</span>",
        formatted_used))
end

-- Function to get used RAM information
function get_used_ram()
    local f = io.open("/proc/meminfo")
    local total, available

    for line in f:lines() do
        local key, value = line:match("(%w+):%s+(%d+)")
        if key == "MemTotal" then
            total = tonumber(value)
        elseif key == "MemAvailable" then
            available = tonumber(value)
        end
    end

    f:close()

    local used = total - available
    return math.floor(used / 1024)
end

-- Update the RAM widget every 5 seconds
awful.widget.watch("bash -c 'free -b | grep Mem | awk \"{print $3}\"'", 5, function(widget, stdout)
    update_ram_widget()
end)

-- kernel widget
-- Function to get the kernel version
function get_kernel_version()
    local f = io.popen("uname -r")
    local kernel_version = f:read("*a")
    f:close()
    return string.gsub(kernel_version, "\n", "")
end

-- Create a text widget for the kernel version
kernel_widget = wibox.widget {
    font = theme.font,
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox(),
}
kernel_widget:set_markup(string.format("<span color='#fabd2f'>  </span><span color='#fabd2f'>%s </span>",
    get_kernel_version()))

-- tasklist buttons
local tasklist_buttons = gears.table.join(
    awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", { raise = true })
        end
    end),
    awful.button({}, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
    end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
    end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end)
)

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = awful.util.taglist_buttons,
    })

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style = {
            shape_border_width = 1,
            shape_border_color = black2,
            shape = gears.shape.powerline,
        },
        widget_template = {
            {
                {
                    {
                        {
                            id = "text_role",
                            widget = wibox.widget.textbox,
                            align = "center",
                        },
                        layout = wibox.layout.fixed.horizontal,
                    },
                    left = 15,
                    right = 15,
                    widget = wibox.container.margin,
                },
                widget = wibox.container.background,
            },
            id = "background_role",
            widget = wibox.container.background,
        },
    })

    -- Create the wibox
    s.mywibox = awful.wibar({
        position = "top",
        screen = s,
        height = 22,
        bg = theme.bg_normal,
        fg = theme.fg_normal,
    })


    -- Add widgets to the wibox
    s.mywibox:setup({
        layout = wibox.layout.align.horizontal,
        {
            -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            -- s.mylayoutbox,
            s.mytaglist,
        },

        wibox.widget {
            forced_num_cols = 2,
            forced_num_rows = 1,
            s.mypromptbox,
            --[[ s.mytasklist, ]]
            expand      = true,
            homogeneous = false,
            layout      = wibox.layout.grid
        },
        {
            -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mpdicon,
            theme.mpd.widget,
            --[[ kernel_widget, ]]
            network_widget,
            update_network_widget(),
            ram_widget,
            update_ram_widget(),
            theme.volume,
            bat.widget,
            mytextclock,
            wibox.widget.systray()
        },
    })
end

return theme
