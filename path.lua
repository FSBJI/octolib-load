--[[
Server Name: [#] Центральный Доброград
Server IP:   37.230.137.242:27017
File Path:   addons/local-octolib/lua/octolib/modules/path.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

octolib.path = octolib.path or {}

function octolib.path.current(level)
	assert(isnumber(level) or level == nil, 'level must be a number or nil')

	local path = debug.getinfo(2 + (level or 0), 'S').short_src:Split('/')

	return '/' .. table.concat({ unpack(path, 4, #path - 1) }, '/')
end

function octolib.path.resolve(path, level)
	assert(isstring(path), 'path must be a string')
	assert(isnumber(level) or level == nil, 'level must be a number or nil')

	path = octolib.path.normalize(path)

	if string.StartWith(path, '/') then
		return path
	end

	return octolib.path.join(octolib.path.current(1 + (level or 0)), path)
end

function octolib.path.normalize(path)
	assert(isstring(path), 'path must be a string')

	if path == '.' then
		path = ''
	elseif string.StartWith(path, './') then
		path = string.sub(path, 3)
	end

	local result = {}

	for element in string.gmatch(path, '[^/\\]+') do
		if element == '..' and #result ~= 0 then
			table.remove(result)
		elseif element ~= '' then
			table.insert(result, element)
		end
	end

	return (string.StartWith(path, '/') and '/' or '') .. table.concat(result, '/')
end

function octolib.path.trim(path)
	assert(isstring(path), 'path must be a string')

	return string.Trim(path, '/')
end

function octolib.path.join(...)
	local elements = { ... }
	local result = ''

	for _, element in ipairs(elements) do
		result = result .. octolib.path.normalize(element) .. '/'
	end

	return octolib.path.normalize(result)
end
