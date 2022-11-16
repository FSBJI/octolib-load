--[[
Server Name: [#] Центральный Доброград
Server IP:   37.230.137.242:27017
File Path:   addons/local-octolib/lua/octolib/modules/vars/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

octolib.vars = octolib.vars or {}

local fname = 'octolib_vars.dat'
local function load()
	local txt = file.Read(fname, 'DATA') or '[}'
	octolib.vars = pon.decode(txt) or {}
end
pcall(load)

local function save()
	file.Write(fname, pon.encode(octolib.vars))
end
local saveDebounced = octolib.func.debounce(save, 1)

function octolib.vars.set(var, val, saveNow)

	if not istable(val) and octolib.vars[var] == val then return end
	octolib.vars[var] = val
	if saveNow then
		save()
	else
		saveDebounced()
	end

	hook.Run('octolib.setVar', var, val)

end

function octolib.vars.init(var, val)

	if octolib.vars[var] ~= nil then return end
	octolib.vars.set(var, val)

end

function octolib.vars.get(var)

	return octolib.vars[var]

end
