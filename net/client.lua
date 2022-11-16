--[[
Server Name: [#] Центральный Доброград
Server IP:   37.230.137.242:27017
File Path:   addons/local-octolib/lua/octolib/modules/net/client.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

if (netvars) then return end

netvars = netvars or {}

local entityMeta = FindMetaTable('Entity')
local playerMeta = FindMetaTable('Player')

local stored = {}
local globals = {}

netstream.Hook('nVar', function(index, key, value)
	stored[index] = stored[index] or {}
	stored[index][key] = value
	hook.Run('octolib.netVarUpdate', index, key, value)
end)

netstream.Hook('nDel', function(index)
	if stored[index] then
		for k in pairs(stored[index]) do
			hook.Run('octolib.netVarUpdate', index, k)
		end
	end
	stored[index] = nil
end)

netstream.Hook('nLcl', function(key, value)
	local index = LocalPlayer():EntIndex()
	stored[index] = stored[index] or {}
	stored[index][key] = value
	hook.Run('octolib.netVarUpdate', index, key, value)
end)

netstream.Hook('gVar', function(key, value)
	globals[key] = value
	hook.Run('octolib.netVarUpdate', nil, key, value)
end)

netstream.Hook('netvars_full', function(theirStored, theirGlobals)

	for index, data in pairs(theirStored) do
		for key, value in pairs(data) do
			stored[index] = stored[index] or {}
			stored[index][key] = value
			hook.Run('octolib.netVarUpdate', index, key, value)
		end
	end

	for key, value in pairs(theirGlobals) do
		globals[key] = value
		hook.Run('octolib.netVarUpdate', nil, key, value)
	end

end)

function netvars.GetNetVar(key, default)
	local value = globals[key]
	if value ~= nil then return value end

	return default
end

function entityMeta:GetNetVar(key, default)
	local index = self:EntIndex()

	local tbl = stored[index]
	if tbl and tbl[key] ~= nil then return tbl[key] end

	return default
end

function entityMeta:SetNetVar(key, default)
	-- wut? some addons use it for some reason
end

playerMeta.GetNetVar = entityMeta.GetNetVar
playerMeta.GetLocalVar = entityMeta.GetNetVar
