--[[
Server Name: [#] Центральный Доброград
Server IP:   37.230.137.242:27017
File Path:   addons/local-octolib/lua/octolib/modules/config/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

-- TODO: implement config

-- octolib.config = octolib.config or {}
-- octolib.config.storedOptions = octolib.config.storedOptions or {}
-- octolib.config.types = octolib.config.types or {}

-- octolib.include.prefixed('meta')
-- octolib.include.prefixed('contract')
-- octolib.include.client('vgui')

-- function octolib.config.option(id, optionConfig)
-- 	local option
-- 	if octolib.config.storedOptions[id] then
-- 		option = octolib.config.storedOptions[id]
-- 	else
-- 		option = setmetatable({ id = id }, octolib.meta.stored.configOption)
-- 		option:Load()
-- 	end

-- 	if optionConfig then table.Merge(option, optionConfig) end

-- 	octolib.config.storedOptions[id] = option

-- 	return option
-- end

-- function octolib.config.defineType(name, options)
-- 	local type
-- 	local changed = false
-- 	if octolib.config.types[name] then
-- 		type = octolib.config.types[name]

-- 		if options then
-- 			table.Merge(type, options)
-- 			changed = true
-- 		end
-- 	else
-- 		type = options
-- 		changed = true
-- 	end

-- 	if changed then
-- 		octolib.config.types[name] = type
-- 	end

-- 	return type
-- end
