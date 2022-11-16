--addons/_config/lua/config/octolib_sh.lua
---------------------------------------------------------------------
-- GENERAL
---------------------------------------------------------------------
if CLIENT then
	netstream.Hook('octolib.cfg', function(cfg)
		table.Merge(CFG, cfg)
		hook.Run('octolib.configLoaded', CFG)
	end)
end

CFG.serverLang = 'ru'
CFG.serverID = 'games'
CFG.serverIDfull = 'games'
CFG.serverIDvars = 'games'

CFG.modules = {
	afk = true,
	anim = true,
	-- backup = true,
	database = true,
	dbvars = true,
	delay = true,
	devtools = true,
	entries = true,
	-- errors = true,
	grab = true,
	hooks = true,
	markers = true,
	move = true,
	net = true,
	notify = true,
	panels = true,
	players = true,
	request = true,
	rewards = true,
	skin = true,
	-- test = true,
	-- use = true,
	questions = true,
	whitelist = true,
}

---------------------------------------------------------------------
-- AFK
---------------------------------------------------------------------
CFG.afkTime = 60 * 3
CFG.afkKickTime = 60 * 30
CFG.afkAdminNotActive = 60 * 15
CFG.drawOverlay = true

---------------------------------------------------------------------
-- PLAYER
---------------------------------------------------------------------
CFG.playerTickTime = 1

if CLIENT then
	---------------------------------------------------------------------
	-- SKIN
	---------------------------------------------------------------------
	local cols = {
		b = Color(25,115,174, 255),
		y = Color(227,176,71, 255),
		r = Color(213,103,83, 255),
		g = Color(209,162,65, 255),
		o = Color(170,119,102, 255),

		bg = Color(43,51,51, 255),
	}

	cols.bg95 = Color(cols.bg.r, cols.bg.g, cols.bg.b, 241)
	cols.bg60 = Color(cols.bg.r, cols.bg.g, cols.bg.b, 150)

	cols.bg_d = Color(cols.bg.r * 0.75, cols.bg.g * 0.75, cols.bg.b * 0.75, 255)
	cols.bg_l = Color(cols.bg.r * 1.25, cols.bg.g * 1.25, cols.bg.b * 1.25, 255)
	cols.bg_grey = Color(180,180,180, 255)
	cols.g_d = Color(cols.g.r * 0.75, cols.g.g * 0.75, cols.g.b * 0.75, 255)
	cols.r_d = Color(cols.r.r * 0.75, cols.r.g * 0.75, cols.r.b * 0.75, 255)

	cols.hvr = Color(0,0,0, 50)
	cols.dsb = Color(255,255,255, 50)

	CFG.skinColors = cols
end
