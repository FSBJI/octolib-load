--[[
Server Name: [#] Центральный Доброград
Server IP:   37.230.137.242:27017
File Path:   addons/local-octolib/lua/octolib/modules/_client/timer-message.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

surface.CreateFont('octolib.timer.normal', {
	font = 'Calibri',
	extended = true,
	size = 27,
	weight = 350,
})

surface.CreateFont('octolib.timer.normal-sh', {
	font = 'Calibri',
	extended = true,
	size = 27,
	weight = 350,
	blursize = 3,
})

local message, timeFinish
netstream.Hook('octolib.timer', function(text, delay)
	message = text
	timeFinish = CurTime() + delay
end)

local function niceTime(time)

	local m, s
	m = math.floor(time / 60) % 60
	s = math.floor(time) % 60

	return string.format('%02i:%02i', m, s)

end

hook.Add('HUDPaint', 'octolib.timer', function()

	if not timeFinish then return end

	local timeLeft = timeFinish - CurTime()
	local text = message:format(niceTime(math.max(timeLeft, 0)))

	if timeLeft < 0 then
		surface.SetAlphaMultiplier(timeLeft + 1)
	end

	draw.DrawText(text, 'octolib.timer.normal-sh', 10, 5, color_black)
	draw.DrawText(text, 'octolib.timer.normal', 10, 5, color_white)

	surface.SetAlphaMultiplier(1)

	if timeLeft <= -1 then
		text, timeFinish = nil
	end

end)