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
theme.font = "Hack Nerd Font Mono Bold 9"
theme.taglist_font = "Symbols Nerd Font Mono 9"

theme.bg_normal = black
theme.bg_focus = green
theme.bg_urgent = red
theme.fg_normal = white
theme.fg_focus = black
theme.fg_urgent = black
theme.bg_systray = black
theme.border_width = 2
theme.border_normal = black2
theme.border_focus = blue
theme.border_marked = aqua
theme.widget_temp = theme.confdir .. "/icons/temp.png"
theme.widget_uptime = theme.confdir .. "/icons/ac.png"
theme.widget_cpu = theme.confdir .. "/icons/cpu.png"
theme.widget_weather = theme.confdir .. "/icons/dish.png"
theme.widget_fs = theme.confdir .. "/icons/fs.png"
theme.widget_mem = theme.confdir .. "/icons/mem.png"
theme.widget_note = theme.confdir .. "/icons/note.png"
theme.widget_note_on = theme.confdir .. "/icons/note_on.png"
theme.widget_netdown = theme.confdir .. "/icons/net_down.png"
theme.widget_netup = theme.confdir .. "/icons/net_up.png"
theme.widget_mail = theme.confdir .. "/icons/mail.png"
theme.widget_batt = theme.confdir .. "/icons/bat.png"
theme.widget_clock = theme.confdir .. "/icons/clock.png"
theme.widget_vol = theme.confdir .. "/icons/spkr.png"
theme.taglist_squares_sel = theme.confdir .. "/taglist/linefw.png"
theme.taglist_squares_unsel = theme.confdir .. "/taglist/linew.png"
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon = true
theme.useless_gap = dpi(4)

local markup = lain.util.markup

os.setlocale(os.getenv("LANG"))

local mytextclock =
	wibox.widget.textclock(markup(blue, "%l:%M:%p") .. markup(green, " || ") .. markup(orange, "%d-%b-%a "))
mytextclock.font = theme.font

-- calender
theme.cal = lain.widget.cal({
	attach_to = { mytextclock },
	notification_preset = {
		font = theme.font,
		fg = green,
		bg = black,
	},
})

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_batt)
local bat = lain.widget.bat({
	settings = function()
		local perc = bat_now.perc ~= "N/A" and bat_now.perc .. "%" or bat_now.perc

		if bat_now.ac_status == 1 then
			perc = perc .. " plug"
		end

		widget:set_markup(markup.fontfg(theme.font, purple, perc .. " "))
	end,
})

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local memory = lain.widget.mem({
	settings = function()
		widget:set_markup(markup.fontfg(theme.font, yellow, mem_now.used .. "M"))
	end,
})
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

-- MPD
local mpdicon = wibox.widget.imagebox()
theme.mpd = lain.widget.mpd({
	settings = function()
		mpd_notification_preset = {
			text = string.format("%s [%s] - %s\n%s", mpd_now.artist, mpd_now.album, mpd_now.date, mpd_now.title),
		}

		if mpd_now.state == "play" then
			artist = mpd_now.artist .. " > "
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
		widget:set_markup(markup.fontfg(theme.font, orange, artist) .. markup.fontfg(theme.font, aqua, title))
	end,
})

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
			s.mypromptbox,
		},
		s.mytasklist, -- Middle widget
		-- nil,
		{
			-- Right widgets
			layout = wibox.layout.fixed.horizontal,
			mpdicon,
			theme.mpd.widget,
			wibox.widget.systray(),
			memicon,
			memory.widget,
			baticon,
			bat.widget,
			mytextclock,
		},
	})
end

return theme
