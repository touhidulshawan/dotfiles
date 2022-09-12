local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local os = os

local theme = {}
theme.confdir = os.getenv("HOME") .. "/.config/awesome/themes/dracula"
theme.wallpaper = theme.confdir .. "/arch.png"
theme.font = "Hack Nerd Font Bold 9"

-- default colors
theme.black = "#282a36"
theme.red = "#ff5555"
theme.green = "#50fa7b"
theme.cyan = "#8be9fd"
theme.pink = "#ff79c6"
theme.white = "#f8f8f2"
theme.yellow = "#f1fa8c"
theme.orange = "#ffb86c"
theme.purple = "#bd93f9"
theme.selection = "#44475a"
theme.comment = "#6272a4"


theme.bg_normal = theme.black
theme.bg_focus = theme.selection
theme.bg_urgent = theme.red
theme.fg_normal = theme.white
theme.fg_focus = theme.green
theme.fg_urgent = theme.black
theme.bg_systray = theme.black
theme.border_width = dpi(2)
theme.border_normal = theme.purple
theme.border_focus = theme.pink
theme.border_marked = theme.cyan
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
theme.taglist_squares_sel = theme.confdir .. "/icons/square_a.png"
theme.taglist_squares_unsel = theme.confdir .. "/icons/square_b.png"
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon = true
theme.useless_gap = dpi(4)

local markup = lain.util.markup

os.setlocale(os.getenv("LANG"))
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local mytextclock = wibox.widget.textclock(
	markup(theme.orange, "%l:%M:%p") .. markup(theme.yellow, " / ") .. markup(theme.red, "%d-%b-%a ")
)
mytextclock.font = theme.font

-- calender
theme.cal = lain.widget.cal({
	attach_to = { mytextclock },
	notification_preset = {
		font = theme.font,
		fg = theme.pink,
		bg = theme.bg_normal,
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

		widget:set_markup(markup.fontfg(theme.font, theme.fg_normal, perc .. " "))
	end,
})
-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local memory = lain.widget.mem({
	settings = function()
		widget:set_markup(markup.fontfg(theme.font, theme.green, mem_now.used .. "M"))
	end,
})

-- tasklist buttons
local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal(
				"request::activate",
				"tasklist",
				{ raise = true }
			)
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
	end))

-- MPD
local mpdicon = wibox.widget.imagebox()
theme.mpd = lain.widget.mpd({
	settings = function()
		mpd_notification_preset = {
			text = string.format("%s [%s] - %s\n%s", mpd_now.artist,
				mpd_now.album, mpd_now.date, mpd_now.title)
		}

		if mpd_now.state == "play" then
			artist = mpd_now.artist .. " > "
			title  = mpd_now.title .. " "
			mpdicon:set_image(theme.widget_note_on)
		elseif mpd_now.state == "pause" then
			artist = "mpd "
			title  = "paused "
		else
			artist                 = ""
			title                  = ""
			--mpdicon:set_image() -- not working in 4.0
			mpdicon._private.image = nil
			mpdicon:emit_signal("widget::redraw_needed")
			mpdicon:emit_signal("widget::layout_changed")
		end
		widget:set_markup(markup.fontfg(theme.font, magenta, artist) .. markup.fontfg(theme.font, blue, title))
	end
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
	s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

	-- Create tasklist widget.
	s.mytasklist = awful.widget.tasklist {
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons
	}

	-- Create the wibox
	s.mywibox = awful.wibar({
		position = "top",
		screen = s,
		height = 20,
		bg = theme.bg_normal,
		fg = theme.fg_normal,
	})

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			-- s.mylayoutbox,
			s.mytaglist,
			s.mypromptbox,
		},
		s.mytasklist, -- Middle widget
		{ -- Right widgets
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
