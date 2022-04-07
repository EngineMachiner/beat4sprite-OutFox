
local prefs = BGA_G.SW.GetPrefs()
local subTheme = prefs.subTheme
local ColorTable = prefs.Colors

local GraphP = BGA_G.GetThemesPath() .. "default/Graphics/"
local path = GraphP .. "_bg big grid.png"

local function CreateTemplate()
	return Def.Sprite {
		OnCommand=function(self)
			BGA_G.ObjFuncs(self)
			self:Load(path):diffuse( ColorTable.titleBGPattern ):diffusealpha(0.125)
			self:diffuseshift():effectperiod(2):effectcolor1(color("#808080"))
			self:blend('add'):zoomto(SCREEN_WIDTH*2,SCREEN_HEIGHT*2.5)
			self:customtexturerect(0,0,SCREEN_WIDTH*4/512,SCREEN_HEIGHT*4/512)
			self:Center():set_use_effect_clock_for_texcoords(true)
			self:queuecommand("Extra")
		end
	}
end

local LoadMenuBG = Def.ActorFrame { CreateTemplate() }

LoadMenuBG[1].ExtraCommand=function(self)
	local d = self:GetDelay() * 8
	self:queuecommand("ScrollY")
	self:linear(d):rotationx(20):rotationy(20)
	self:linear(d):rotationx(0)
	self:queuecommand("ScrollX")
	self:linear(d):rotationy(0)
	self:linear(d):rotationy(20)
	self:queuecommand("Extra")
end

LoadMenuBG[1].ScrollXCommand=function(self)
	local d = self:GetDelay() * 0.125
	self:texcoordvelocity(d,0)
end

LoadMenuBG[1].ScrollYCommand=function(self)
	local d = self:GetDelay() * 0.125
	self:texcoordvelocity(0,d)
end

return BGA_G.Frame() .. {
	InitCommand=function(self) 
		self:fov(80)
		BGA_G.ObjFuncs(self) self:Center3D()
	end,
	OnCommand=BGA_G.ConvertToGamePlay,
	BGA_G.SW.BG(),	LoadMenuBG
}
