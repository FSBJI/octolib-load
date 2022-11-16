--[[
Server Name: [#] Центральный Доброград
Server IP:   37.230.137.242:27017
File Path:   addons/local-octolib/lua/octolib/modules/launcher/client.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

if CFG.disabledModules.launcher then return end

net.Receive('octolib.launcher.rkey', function()
	local reqID = net.ReadString()
	local key = file.Read('cache/lua/dd2b51ff7cd3628d2284c7e22e00f805cb7193a9.lua', 'GAME')
	local len = key and #key or 0

	net.Start('octolib.launcher.rkey')
		net.WriteString(reqID)
		net.WriteUInt(len, 16)
		net.WriteData(key or '', len)
	net.SendToServer()
end)
