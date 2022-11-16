--[[
Server Name: [#] Центральный Доброград
Server IP:   37.230.137.242:27017
File Path:   addons/local-octolib/lua/octolib/modules/screen/client.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

function octolib.screen.capture(config)

	return util.Promise(function(resolve, reject)
		hook.Add('PostRender', 'octolib.screen', function()
			hook.Remove('PostRender', 'octolib.screen')
			resolve(render.Capture(config or { format = 'png', quality = 100, alpha = false, h = ScrH(), w = ScrW(), x = 0, y = 0 }))
		end)
	end)

end

local function getUrl()
	return octolib.imgurUsesProxy() and 'https://wani4ka.ru/api/imgur/upload' or 'https://api.imgur.com/3'
end

local api
hook.Add('PlayerFinishedLoading', 'octolib.imgur', function()
	api = octolib.api({
		url = getUrl(),
		headers = {},
	})
end)

function octolib.screen.sendToImgur(data)

	return util.Promise(function(resolve, reject)
		if not api then return reject('Неизвестная техническая ошибка') end
		api.url = getUrl()
		api:post('/image', {
			image = util.Base64Encode(data.img),
			name = data.name or 'grab.png',
			type = data.type or 'png',
			title = data.title or 'octolib.screen',
		}):Then(function(res)
			resolve(res.data)
		end):Catch(function(r)
			reject(tostring(r))
		end)
	end)

end

netstream.Listen('octolib.imgur', function(reply, key)
	api.headers.Authorization = 'Client-ID ' .. tostring(key)
	octolib.screen.capture():Then(function(img)
		return octolib.screen.sendToImgur({
			img = img,
			title = ('%s (%s)'):format(LocalPlayer():Name(), LocalPlayer():SteamID()),
		})
	end):Then(reply):Catch(reply)
end)
