--[[
Server Name: [#] Центральный Доброград
Server IP:   37.230.137.242:27017
File Path:   addons/local-octolib/lua/octolib/modules/anim/cl_menu.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

function octolib.createAnimSelectMenu()

	local hasDonate = LocalPlayer():GetNetVar('os_dobro')

	local menu = DermaMenu()

	for catID, cat in SortedPairsByMemberValue(octolib.animations, 'order') do
		local catOpt = menu:AddSubMenu(cat.name)

		for i, anim in pairs(cat.anims) do
			local opt = catOpt:AddOption(anim[1], function() netstream.Start('player-anim', catID, i) end)
			if cat.donate and not hasDonate then opt:SetAlpha(75) end
		end
	end

	local rows = octolib.vars.get('faceposes') or {}
	local catOpt = menu:AddSubMenu('Эмоции')
	catOpt:AddOption('Нейтральность', function() netstream.Start('player-flex', {}) end)
	for _, row in pairs(rows) do
		catOpt:AddOption(row.name, function() netstream.Start('player-flex', row.flexes) end)
	end
	if #rows > 0 then catOpt:AddSpacer() end
	catOpt:AddOption('Редактор эмоций...', function()
		octolib.dataEditor.open('faceposes')
	end):SetIcon('icon16/pencil.png')

	return menu

end

hook.Add('CreateMove', 'player-anim', function()

	if input.WasKeyPressed(KEY_F2) and not vgui.CursorVisible() then
		gui.EnableScreenClicker(true)

		local menu = octolib.createAnimSelectMenu()
		menu:Open()
		menu:Center()

		gui.EnableScreenClicker(false)
	end

end)
