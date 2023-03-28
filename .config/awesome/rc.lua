pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local beautiful = require("beautiful")
local naughty = require("naughty")
local lain = require("lain")
-- local menubar       = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local dpi = require("beautiful.xresources").apply_dpi
require("awful.hotkeys_popup.keys")
local mytable = awful.util.table or gears.table

-- {{{ Error handling

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors,
	})
end

-- Handle runtime errors after startup
do
	local in_error = false

	awesome.connect_signal("debug::error", function(err)
		if in_error then
			return
		end

		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err),
		})

		in_error = false
	end)
end

-- }}}

-- {{{ Autostart windowless processes

-- This function will run once every time Awesome is started
local function run_once(cmd_arr)
	for _, cmd in ipairs(cmd_arr) do
		awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
	end
end

-- Notification configuration
naughty.config.defaults = {
	timeout = 10,
	hover_timeout = 300,
	text = "",
	screen = 1,
	ontop = true,
	margin = dpi(16),
	border_width = 0,
	position = "top_right",
	width = 400,
	max_width = 400,
	icon_size = dpi(75),
}
naughty.config.padding = dpi(4)
naughty.config.spacing = dpi(4)
naughty.config.icon_dirs = {
	'/usr/share/icons/Papirus-Dark/',
}
naughty.config.icon_formats = { 'svg', 'png', 'jpg', 'gif' }

-- {{{ Variable definitions
local themes = { "gruvbox", "dracula" }

local chosen_theme = themes[1]
local modkey = "Mod4"
local altkey = "Mod1"
local controlkey = "Control"
local shiftkey = "Shift"
local terminal = "alacritty"
local vi_focus = false  -- vi-like client focus https://github.com/lcpz/awesome-copycats/issues/275
local cycle_prev = true -- cycle with only the previously focused client or all https://github.com/lcpz/awesome-copycats/issues/274
local editor = os.getenv("EDITOR") or "emacs"
local browser = "firefox"
local filemanager = "thunar"
local home = os.getenv("HOME")

awful.util.terminal = terminal
awful.util.tagnames = {
	"    ",
	"    ",
	"    ",
	"    ",
	"    ",
	"    ",
	"    ",
	"    ",
}
awful.layout.layouts = {
	awful.layout.suit.tile,
}

lain.layout.termfair.nmaster = 3
lain.layout.termfair.ncol = 1
lain.layout.termfair.center.nmaster = 3
lain.layout.termfair.center.ncol = 1
lain.layout.cascade.tile.offset_x = 2
lain.layout.cascade.tile.offset_y = 32
lain.layout.cascade.tile.extra_padding = 5
lain.layout.cascade.tile.nmaster = 5
lain.layout.cascade.tile.ncol = 2

awful.util.taglist_buttons = mytable.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

awful.util.tasklist_buttons = mytable.join(
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

beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))

-- }}}

-- {{{ Screen

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end)

-- No borders when rearranging only 1 non-floating or maximized client
-- screen.connect_signal(
--     "arrange",
--     function(s)
--         local only_one = #s.tiled_clients == 1
--         for _, c in pairs(s.clients) do
--             if only_one and not c.floating or c.maximized or c.fullscreen then
--                 c.border_width = 0
--             else
--                 c.border_width = beautiful.border_width
--             end
--         end
--     end
-- )

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s)
	beautiful.at_screen_connect(s)
end)

-- }}}

-- {{{ Key bindings

globalkeys = mytable.join( -- Destroy all notifications
	awful.key({ controlkey }, "space", function()
		naughty.destroy_all_notifications()
	end, { description = "destroy all notifications", group = "hotkeys" }), -- Show help
	awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
	awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
	awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
	awful.key({ altkey }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),
	awful.key({ altkey }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }), -- By-direction client focus
	awful.key({ modkey }, "j", function()
		awful.client.focus.global_bydirection("down")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus down", group = "client" }),
	awful.key({ modkey }, "k", function()
		awful.client.focus.global_bydirection("up")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus up", group = "client" }),
	awful.key({ modkey }, "h", function()
		awful.client.focus.global_bydirection("left")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus left", group = "client" }),
	awful.key({ modkey }, "l", function()
		awful.client.focus.global_bydirection("right")
		if client.focus then
			client.focus:raise()
		end
	end, { description = "focus right", group = "client" }), -- Layout manipulation
	awful.key({ modkey, shiftkey }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),
	awful.key({ modkey, shiftkey }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),
	awful.key({ modkey, controlkey }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),
	awful.key({ modkey, controlkey }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),
	awful.key({ modkey }, "u", awful.client.urgent.jumpto,
		{ description = "jump to urgent client", group = "client" }),
	awful.key({ modkey }, "Tab", function()
		if cycle_prev then
			awful.client.focus.history.previous()
		else
			awful.client.focus.byidx(-1)
		end
		if client.focus then
			client.focus:raise()
		end
	end, { description = "cycle with previous/go back", group = "client" }),
	-- Show/hide wibox
	awful.key({ modkey }, "w", function()
		for s in screen do
			s.mywibox.visible = not s.mywibox.visible
			if s.mybottomwibox then
				s.mybottomwibox.visible = not s.mybottomwibox.visible
			end
		end
	end, { description = "toggle wibox", group = "awesome" }),
	-- On-the-fly useless gaps change
	awful.key({ altkey, controlkey }, "+", function()
		lain.util.useless_gaps_resize(1)
	end, { description = "increment useless gaps", group = "tag" }),
	awful.key({ altkey, controlkey }, "-", function()
		lain.util.useless_gaps_resize(-1)
	end, { description = "decrement useless gaps", group = "tag" }),
	-- Dynamic tagging
	awful.key({ modkey, shiftkey }, "n", function()
		lain.util.add_tag()
	end, { description = "add new tag", group = "tag" }),
	awful.key({ modkey, shiftkey }, "r", function()
		lain.util.rename_tag()
	end, { description = "rename tag", group = "tag" }),
	awful.key({ modkey, shiftkey }, "Left", function()
		lain.util.move_tag(-1)
	end, { description = "move tag to the left", group = "tag" }),
	awful.key({ modkey, shiftkey }, "Right", function()
		lain.util.move_tag(1)
	end, { description = "move tag to the right", group = "tag" }),
	awful.key({ modkey, shiftkey }, "d", function()
		lain.util.delete_tag()
	end, { description = "delete tag", group = "tag" }),
	-- Standard program
	awful.key({ modkey }, "Return", function()
		awful.spawn(terminal)
	end, { description = "open a terminal", group = "launcher" }),
	awful.key({ modkey, controlkey }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ modkey, shiftkey }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
	awful.key({ modkey, altkey }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),
	awful.key({ modkey, altkey }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),
	awful.key({ modkey, shiftkey }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),
	awful.key({ modkey, shiftkey }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),
	awful.key({ modkey, controlkey }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),
	awful.key({ modkey, controlkey }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),
	awful.key({ modkey }, "space", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),
	awful.key({ modkey, shiftkey }, "space", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),
	awful.key({ modkey, controlkey }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "restore minimized", group = "client" }),
	-- Widgets popups
	awful.key({ altkey }, "c", function()
		if beautiful.cal then
			beautiful.cal.show(7)
		end
	end, { description = "show calendar", group = "widgets" }),
	-- Screen brightness
	awful.key({}, "XF86MonBrightnessUp", function()
		awful.util.spawn("sh " .. home .. "/.local/bin/changebrightness up")
	end, { description = "+5%", group = "hotkeys" }),
	awful.key({}, "XF86MonBrightnessDown", function()
		awful.util.spawn("sh " .. home .. "/.local/bin/changebrightness down")
	end, { description = "-5%", group = "hotkeys" }),
	awful.key({ modkey }, "c", function()
		awful.spawn.with_shell("xsel | xsel -i -b")
	end, { description = "copy terminal to gtk", group = "hotkeys" }),
	-- Copy clipboard to primary (gtk to terminals)
	awful.key({ modkey }, "v", function()
		awful.spawn.with_shell("xsel -b | xsel")
	end, { description = "copy gtk to terminal", group = "hotkeys" }),
	-- MPD control
	awful.key({ altkey, "Control" }, "Up", function()
		os.execute("mpc toggle")
		beautiful.mpd.update()
	end, { description = "mpc toggle", group = "widgets" }),
	awful.key({ altkey, "Control" }, "Down", function()
		os.execute("mpc stop")
		beautiful.mpd.update()
	end, { description = "mpc stop", group = "widgets" }),
	awful.key({ altkey, "Control" }, "Left", function()
		os.execute("mpc prev")
		beautiful.mpd.update()
	end, { description = "mpc prev", group = "widgets" }),
	awful.key({ altkey, "Control" }, "Right", function()
		os.execute("mpc next")
		beautiful.mpd.update()
	end, { description = "mpc next", group = "widgets" }),
	awful.key({ altkey }, "0", function()
		local common = { text = "MPD widget ", position = "top_middle", timeout = 2 }
		if beautiful.mpd.timer.started then
			beautiful.mpd.timer:stop()
			common.text = common.text .. lain.util.markup.bold("OFF")
		else
			beautiful.mpd.timer:start()
			common.text = common.text .. lain.util.markup.bold("ON")
		end
		naughty.notify(common)
	end, { description = "mpc on/off", group = "widgets" }),
	-- User programs
	-- Random wallpapers
	awful.key({ modkey, shiftkey }, "w", function()
		awful.util.spawn("sh " .. home .. "/.local/bin/wallpaper random")
	end, { description = "set wallpaper randomly", group = "misc" }),
	-- select wallpapers
	awful.key({ modkey, shiftkey }, "s", function()
		awful.util.spawn("sh " .. home .. "/.local/bin/wallpaper show")
	end, { description = "view and set wallpaper", group = "misc" }),
	-- launch emoji
	awful.key({ modkey }, ".", function()
		awful.util.spawn("emote")
	end, { description = "launch emoji", group = "emoji" }),
	--  run rofi
	awful.key({ altkey }, "space", function()
		awful.util.spawn('rofi -show drun -icon-theme "Papirus-Dark" -show-icons')
	end, { description = "launch rofi", group = "launcher" }),
	--  run rofi to navigate all active window
	awful.key({ altkey, shiftkey }, "space", function()
		awful.util.spawn('rofi -show window -icon-theme "Papirus-Dark" -show-icons')
	end, { description = "launch rofi to navigate active window", group = "launcher" }),
	-- launch power menu
	awful.key({ modkey, altkey }, "space", function()
		awful.util.spawn("sh " .. home .. "/.local/bin/powermenu")
	end, { description = "launch power menu in rofi", group = "launcher" }),
	-- launch gui filemanager
	awful.key({ modkey }, "e", function()
		awful.util.spawn(filemanager)
	end, { description = "launch gui filemanager", group = "application" }),
	-- launch Firefox with Master Profile (default)
	awful.key({ modkey }, "b", function()
		awful.util.spawn(browser)
	end, { description = "launch Firefox browser with Master Profile", group = "browser" }),
	-- launch Firefox with Entertainment Profile
	awful.key({ modkey, shiftkey }, "e", function()
		awful.util.spawn(browser .. " -P Entertainment")
	end, { description = "launch Firefox browser with Entertainment Profile", group = "browser" }),
	-- launch Firefox with Pentest Profile
	awful.key({ modkey, shiftkey }, "p", function()
		awful.util.spawn(browser .. " -P Pentest")
	end, { description = "launch Firefox browser with Pentest Profile", group = "browser" }),
	-- launch Firefox private window
	awful.key({ modkey, shiftkey }, "i", function()
		awful.util.spawn(browser .. " --private-window")
	end, { description = "launch Firefox with private window", group = "browser" }),
	-- ScreenShot
	awful.key({}, "Print", function()
		awful.util.spawn("sh " .. home .. "/.local/bin/screenshot")
	end, { description = "take screenshots", group = "screenshot" }),
	-- Screenshots by selecting area
	awful.key({ shiftkey }, "Print", function()
		awful.util.spawn("sh " .. home .. "/.local/bin/screenshot select")
	end, { description = "take screenshots by selecting area", group = "screenshot" }),
	-- Screenshot of focused window
	awful.key({ controlkey }, "Print", function()
		awful.util.spawn("sh " .. home .. "/.local/bin/screenshot window")
	end, { description = "take screenshot focused window", group = "screenshot" }),
	-- lockscreen
	awful.key({ modkey, controlkey }, "l", function()
		awful.util.spawn("betterlockscreen -l")
	end, { description = "Lockscreen", group = "lockscreen" }),
	-- launch copyq window
	awful.key({ modkey }, "a", function()
		awful.util.spawn("copyq toggle")
	end, { description = "open copyq window", group = "clipboard" }),
	-- launch emacs
	awful.key({ modkey }, "o", function()
		awful.util.spawn("emacsclient -c -a 'emacs'")
	end, { description = "open emacs", group = "editor" }),
	-- launch zathura
	awful.key({ modkey }, "p", function()
		awful.util.spawn("zathura")
	end, { description = "open zathura", group = "reader" })
)

clientkeys = mytable.join(
	awful.key({ altkey, shiftkey }, "m", lain.util.magnify_client, {
		description = "magnify client",
		group = "client",
	}),
	awful.key({ modkey }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),
	awful.key({ modkey }, "q", function(c)
		c:kill()
	end, { description = "close", group = "client" }),
	awful.key({ modkey, controlkey }, "space", awful.client.floating.toggle, {
		description = "toggle floating",
		group = "client",
	}),
	awful.key({ modkey, shiftkey }, "y", awful.placement.centered, {
		description = "centered floating window",
		group = "client",
	}),
	awful.key({ modkey, controlkey }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "move to master", group = "client" }),
	awful.key({ modkey }, "o", function(c)
		c:move_to_screen()
	end, { description = "move to screen", group = "client" }),
	awful.key({ modkey }, "t", function(c)
		c.ontop = not c.ontop
	end, { description = "toggle keep on top", group = "client" }),
	awful.key({ modkey }, "n", function(c)
		c.minimized = true
	end, { description = "minimize", group = "client" }),
	awful.key({ modkey }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" }),
	awful.key({ modkey, controlkey }, "m", function(c)
		c.maximized_vertical = not c.maximized_vertical
		c:raise()
	end, { description = "(un)maximize vertically", group = "client" }),
	awful.key({ modkey, shiftkey }, "m", function(c)
		c.maximized_horizontal = not c.maximized_horizontal
		c:raise()
	end, { description = "(un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = mytable.join(
		globalkeys, -- View tag only.
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, { description = "view tag #" .. i, group = "tag" }),
		-- Toggle tag display.
		awful.key({ modkey, controlkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, { description = "toggle tag #" .. i, group = "tag" }),
		-- Move client to tag.
		awful.key({ modkey, shiftkey }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" }),
		-- Toggle tag on focused client.
		awful.key({ modkey, controlkey, shiftkey }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, { description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

clientbuttons = mytable.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- Set keys
root.keys(globalkeys)

-- }}}

-- {{{ Rules

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
			size_hints_honor = false,
		},
	}, -- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin", -- kalarm.
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
				"Gcr-prompter",
				"Lxpolkit",
				"Emote",
			},
			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = { floating = true, placement = awful.placement.centered },
	}, -- Add titlebars to normal clients and dialogs
	{
		rule_any = { type = { "normal", "dialog" } },
		properties = { titlebars_enabled = false },
	},
	{
		rule_any = { class = { "librewolf", "firefox", "Google-chrome", "Chromium", "Brave-browser" } },
		properties = { screen = 1, tag = "    ", switchtotag = true },
	},
	{
		rule_any = { class = { "Code", "Atom", "VSCodium", "jetbrains-studio", "Emacs" } },
		properties = { screen = 1, tag = "    ", switchtotag = true },
	},
	{
		rule_any = { class = { "Thunar", "Pcmanfm", "vlc", "Transmission-gtk", "qBittorrent" } },
		properties = { screen = 1, tag = "    " },
	},
	{
		rule_any = { class = { "Gimp-2.10", "obs", "Evince", "Inkscape", "Zathura" } },
		properties = { screen = 1, tag = "    " },
	},
	{
		rule_any = { class = { "zoom " } },
		properties = { screen = 1, tag = "    " },
	},
	{
		rule_any = { class = { "burp-StartBurp", "Wireshark", "Ettercap", "org-zaproxy-zap-ZAP" } },
		properties = { screen = 1, tag = "    ", switchtotag = true },
	},
	{
		rule_any = {
			class = {
				"Nitrogen",
				"Lightdm-gtk-greeter-settings",
				"Lxappearance",
				"qt5ct",
				"Xfce4-power-manager-settings",
				"Kvantum Manager",
				"GParted",
			},
		},
		properties = { screen = 1, tag = "    " },
	},
	{
		rule_any = { class = { "Image Lounge", "feh" } },
		properties = { floating = true, placement = awful.placement.centered },
	},
	{
		rule_any = { class = { "mpv" } },
		properties = { screen = 1, tag = "    ", fullscreen = true, switchtotag = true },
	},
	{
		rule_any = { class = { "Xarchiver", "Gedit", "Catfish" } },
		properties = { screen = 1, tag = "    ", floating = true, placement = awful.placement.centered },
	},
	{
		rule_any = { class = { "VirtualBox Manager", "VirtualBox Machine", "Virt-manager" } },
		properties = { screen = 1, tag = "    ", switchtotag = true },
	},
	{
		rule = { name = "Picture-in-Picture" },
		properties = { sticky = true },
	},
}

-- }}}

-- {{{ Signals

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
	-- c.opacity = 1
end)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
	-- c.opacity = 0.8
end)

-- Autostart
awful.spawn.with_shell("~/.config/awesome/autorun.sh")

-- }}}
