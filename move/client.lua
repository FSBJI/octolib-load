--[[
Server Name: [#] Центральный Доброград
Server IP:   37.230.137.242:27017
File Path:   addons/local-octolib/lua/octolib/modules/move/client.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

if CFG.disabledModules.afk then return end

local cmds = {'duck', 'attack2'}

local last, is, cvar = {}, {}, {}
hook.Add('Think', 'octolib.move', function()
	hook.Remove('Think', 'octolib.move')
	timer.Simple(1, function()
		for i, cmd in ipairs(cmds) do cvar[cmd] = CreateClientConVar('cl_octolib_sticky_' .. cmd, '1') end
	end)
end)

hook.Add('PlayerBindPress', 'octolib.move', function(ply, bind, pressed)

	for i, cmd in ipairs(cmds) do
		if bind == '+' .. cmd and cvar[cmd] and cvar[cmd]:GetBool() then
			if is[cmd] then
				RunConsoleCommand('-' .. cmd)
				is[cmd] = false
			else
				if CurTime() - (last[cmd] or 0) < 0.3 then
					RunConsoleCommand('+' .. cmd)
					is[cmd] = true
				end
				last[cmd] = CurTime()
			end
		end
	end

end)
