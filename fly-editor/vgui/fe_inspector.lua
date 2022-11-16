--[[
Server Name: [#] Центральный Доброград
Server IP:   37.230.137.242:27017
File Path:   addons/local-octolib/lua/octolib/modules/fly-editor/vgui/fe_inspector.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local PANEL = {}

function PANEL:Init()

	self:SetSize(250, 400)
	self:AlignRight(5)
	self:AlignTop(5)

	self.controls = {}
	local c = self.controls

	c.col = self:CreateRow('Properties', 'Color')
	c.col:Setup('VectorColor')
	c.col:SetValue(Vector(1,1,1))
	function c.col.DataChanged(p, strCol)
		if not IsValid(self.ent) then return end
		local vCol = Vector(strCol)
		self.VectorValue = vCol
		self.ent:SetColor(vCol:ToColor())
	end

end

function PANEL:SetEntity(ent)

	self.ent = ent

	local c = self.controls
	local col = ent:GetColor()
	c.col:SetValue(Vector(col.r / 255, col.g / 255, col.b / 255))

end

vgui.Register('fe_inspector', PANEL, 'DProperties')
