--[[
Server Name: [#] Центральный Доброград
Server IP:   37.230.137.242:27017
File Path:   addons/local-octolib/lua/octolib/modules/notify/client.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

octolib.notify.types = octolib.notify.types or {
	_generic = octolib.func.zero,
}

octolib.notify.cache = octolib.notify.cache or {}

function octolib.notify.registerType(type, handler)
	if type == '_generic' and not handler then
		handler = octolib.func.zero
	end
	octolib.notify.types[type] = handler
end

function octolib.notify.show(type, ...)
	local data = {...}
	if not data[1] then
		data = {type}
		type = '_generic'
	end
	type = type or '_generic'

	if octolib.notify.types[type] then octolib.notify.types[type](unpack(data))
	else octolib.notify.types._generic(unpack(data)) end
end

netstream.Hook('octolib.notify', octolib.notify.show)

netstream.Hook('octolib-notifs.add', function(notif)
	octolib.notify.cache[#octolib.notify.cache + 1] = notif
	hook.Run('octolib.notify.cacheUpdate', octolib.notify.cache)
end)

netstream.Hook('octolib-notifs.sync', function(notifs)
	octolib.notify.cache = notifs
	hook.Run('octolib.notify.cacheUpdate', octolib.notify.cache)
end)
