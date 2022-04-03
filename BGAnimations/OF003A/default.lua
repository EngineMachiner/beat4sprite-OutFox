
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
			self:blend('add'):zoomto(SCREEN_WIDTH*1.4,SCREEN_HEIGHT*1.4)
			self:customtexturerect(0,0,SCREEN_WIDTH*4/512,SCREEN_HEIGHT*4/512)
			self:Center():set_use_effect_clock_for_texcoords(true)
			self:queuecommand("Extra")
			self:queuecommand("Alpha")
		end
	}
end

local LoadMenuBG = Def.ActorFrame { CreateTemplate(),	CreateTemplate() }
LoadMenuBG[1].ExtraCommand=function(self)
	local d = self:GetDelay(1) * 0.125
	self:texcoordvelocity(0,d)
end

LoadMenuBG[2].ExtraCommand=function(self)
	local d = self:GetDelay(1) * 0.125
	self:texcoordvelocity(0,-d)
	self:fadeleft(0.4):faderight(0.4)
end

local function Alpha(self, alpha)
	local d = self:GetDelay(1)
	self:diffusealpha(alpha[1])
	self:sleep(d * 3.5):linear(d * 0.5):diffusealpha(alpha[2])
	self:sleep(d * 3.5):linear(d * 0.5):diffusealpha(alpha[1])
	self:queuecommand("Alpha")
end

LoadMenuBG[1].AlphaCommand=function(self) Alpha(self, {0.125, 0}) end
LoadMenuBG[2].AlphaCommand=function(self) Alpha(self, {0, 0.125}) end

return BGA_G.Frame() .. {
	OnCommand=BGA_G.ConvertToGamePlay,
	BGA_G.SW.BG(),	LoadMenuBG
}