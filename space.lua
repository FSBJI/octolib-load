--[[
Server Name: [#] Центральный Доброград
Server IP:   37.230.137.242:27017
File Path:   addons/local-octolib/lua/octolib/modules/space.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

octolib.space = octolib.space or {}

function octolib.space.getMapZ(x, y, dir, maxTries)
	dir = dir and octolib.math.sign(dir) or -1
	maxTries = maxTries or 10

	local tr = {
		HitPos = Vector(x, y, -dir * 5000),
		HitSky = true,
	}

	local tries = 0
	while tr.HitSky or tr.HitNoDraw do
		tr = util.TraceLine {
			start = tr.HitPos + Vector(0, 0, dir),
			endpos = tr.HitPos + Vector(0, 0, dir * 10000),
			collisiongroup = COLLISION_GROUP_WORLD,
		}

		tries = tries + 1
		if tries > maxTries then break end
	end

	local result = tr.HitPos and (tr.HitPos + tr.HitNormal) or Vector(x, y, 0)
	return result.z
end
