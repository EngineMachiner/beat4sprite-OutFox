
local prefs = BGA_G.SW.GetPrefs()
local subTheme = prefs.subTheme
local ColorTable = prefs.Colors

local GraphP = BGA_G.GetThemesPath() .. "default/Graphics/"
local path = GraphP .. "_bg big grid.png"

local function CreateTemplate()
	return Def.Sprite {
		OnCommand=function(self)
			BGA_G.ObjFuncs(self)
			local d = self:GetDelay() * 0.125
			self:GetParent():diffusealpha(0.25)
			self:Load(path):diffuse( ColorTable.titleBGPattern )
			self:blend('add'):zoomto(SCREEN_WIDTH*1.4,SCREEN_HEIGHT*1.4)
			self:customtexturerect(0,0,SCREEN_WIDTH*4/512,SCREEN_HEIGHT*4/512)
			self:Center():set_use_effect_clock_for_texcoords(true)
			self:diffuseshift():effectperiod(4):effectcolor1(color("1,1,1,0.5"))
			self:texcoordvelocity(d,d)
		end
	}
end

return BGA_G.Frame() .. {
	OnCommand=BGA_G.ConvertToGamePlay,
	BGA_G.SW.BG(),	Def.ActorFrame{ CreateTemplate() }
}