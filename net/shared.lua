--[[
Server Name: [#] Центральный Доброград
Server IP:   37.230.137.242:27017
File Path:   addons/local-octolib/lua/octolib/modules/net/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

-- hook.Add("Think", "InitMyOverride", function()
-- 	hook.Remove("Think", "InitMyOverride")

-- 	local PLAYER, ENTITY = FindMetaTable 'Player', FindMetaTable 'Entity'
-- 	local GetTable = ENTITY.GetTable
-- 	local GetOwner = ENTITY.GetOwner

-- 	function PLAYER:__index(key)
-- 		return PLAYER[key] or ENTITY[key] or GetTable(self)[key]
-- 	end

-- 	function ENTITY:__index(key)
-- 		if not key then return end

-- 		local res = (key == "Owner" and GetOwner(self)) or ENTITY[key]
-- 		if res ~= nil then return res end

-- 		local t = GetTable(self)
-- 		if t then return t[key] end
-- 	end

-- 	local cachedValid = {}

-- 	function IsValid(obj)
-- 		if not obj or cachedValid[obj] ~= nil then return obj and cachedValid[obj] end
-- 		local isvalid = obj.IsValid
-- 		cachedValid[obj] = isvalid and isvalid(obj) or false

-- 		return cachedValid[obj]
-- 	end

-- 	hook.Add('Think', 'flushIsValid', function()
-- 		table.Empty(cachedValid)
-- 	end)

-- end)