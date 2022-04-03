
local prefs = BGA_G.SW.GetPrefs()
local subTheme = prefs.subTheme
local ColorTable = prefs.Colors

local GraphP = BGA_G.GetThemesPath() .. "default/Graphics/"
local path = GraphP .. "_retro checkerboard (stretch).png"

local LoadMenuBG = Def.Sprite{
	OnCommand=function(self)
		BGA_G.ObjFuncs(self)
		local d = self:GetDelay(1) * 0.5
		self:Load(path):Center():texcoordvelocity(0,d)
		self:set_tween_uses_effect_delta(true)
		self:diffuse( ColorTable.titleBGPattern )
		self:zoomto(SCREEN_WIDTH*1.4,SCREEN_HEIGHT+190*1.4):diffusealpha(0.5)
		self:customtexturerect(0,0,SCREEN_WIDTH*4/512,SCREEN_HEIGHT*4/512)
		self:rotationx(-20):fadeleft(0.4):faderight(0.4)
	end
}


return BGA_G.Frame() .. {
	OnCommand=function(self) 
		self:fov(80)	BGA_G.bitEyeFix(self)
	end,		LoadMenuBG,		BGA_G.SW.BG()
}