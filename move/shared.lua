--[[
Server Name: [#] Центральный Доброград
Server IP:   37.230.137.242:27017
File Path:   addons/local-octolib/lua/octolib/modules/move/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

if CFG.disabledModules.afk then return end

hook.Add('StartCommand', 'octolib.move', function(ply, cmd)

	local fwd = cmd:GetForwardMove()
	if cmd:KeyDown(IN_SPEED) then
		local side = cmd:GetSideMove()
		if (fwd < 0 or (fwd == 0 and side ~= 0)) and ply:GetMoveType() ~= MOVETYPE_NOCLIP then
			cmd:RemoveKey(IN_SPEED)
			cmd:RemoveKey(IN_WALK)
		end
	end

	if cmd:KeyDown(IN_JUMP) and ply:GetJumpPower() == 0 and not ply:InVehicle() then
		cmd:RemoveKey(IN_JUMP)
	end

	if not cmd:KeyDown(IN_DUCK) and ply:GetNetVar('nostand') and not ply:InVehicle() then
		cmd:SetButtons(cmd:GetButtons() + IN_DUCK)
	end

	if ply:GetNetVar('norun') then
		cmd:RemoveKey(IN_SPEED)
		cmd:RemoveKey(IN_WALK)
	end

end)
