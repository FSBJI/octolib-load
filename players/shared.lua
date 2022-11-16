--[[
Server Name: [#] Центральный Доброград
Server IP:   37.230.137.242:27017
File Path:   addons/local-octolib/lua/octolib/modules/players/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

octolib.players = octolib.players or {}

function octolib.players.resolve(value)
	if isstring(value) then
		return player.GetBySteamID(value), value
	else
		return value, value:SteamID()
	end
end

local Player = FindMetaTable('Player')

function Player:GetEyeTraceLimited(length)
	local aim = self:EyeAngles():Forward()
	local t = {}

	t.start = self:GetShootPos()
	t.endpos = t.start + aim * length
	t.filter = { self }

	hook.Run('octolib.eyeTraceFilter', self, t.filter)

	return util.TraceLine(t)
end

for _, name in ipairs({ 'AccountID', 'SteamID', 'SteamID64', 'UniqueID' }) do
	Player[name] = octolib.func.detour(Player[name], 'Player:' .. name, function(original, player)
		return player:GetNetVar('botID') or original(player)
	end)
end
