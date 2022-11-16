--[[
Server Name: [#] Центральный Доброград
Server IP:   37.230.137.242:27017
File Path:   addons/local-octolib/lua/octolib/modules/css.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

if CFG.disabledModules.css then return end

if SERVER then
	util.PrecacheModel('models/props/cs_assault/money.mdl')

	local texts = {
		{'Кажется, у тебя не установлен (или установлен неправильно) контент CSS!'},
		{'Доброград активно использует этот контент, поэтому с твоей стороны могут наблюдаться различные "Error\'ки", "Эмо-текстуры" и так далее'},
		{'Инструкция по установке CSS-контента: ', {'https://octo.gg/gmod-css'}},
		{'Устранение прочих проблем с контентом: ', {'https://octo.gg/gmod-content'}},
	}

	hook.Add('PlayerFinishedLoading', 'dbg.csscheck', function(ply)
		if ply.cssWarned then return end
		ply.cssWarned = true
		timer.Simple(5, function()
			if not IsValid(ply) then return end
			netstream.Request(ply, 'dbg.csscheck'):Then(function(res)
				if res then return end
				for _, text in ipairs(texts) do
					octochat.talkTo(ply, Color(225,0,0), unpack(text))
				end
			end)
		end)
	end)

else
	netstream.Listen('dbg.csscheck', function(reply)
		reply(util.IsValidModel('models/props/cs_assault/money.mdl'))
	end)
end
