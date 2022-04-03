
local prefs = BGA_G.SW.GetPrefs()
local subTheme = prefs.subTheme
local ColorTable = prefs.Colors

-- 720 is SoundWaves screen Height
local scale = SCREEN_HEIGHT / 720

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
		end
	}
end

local LoadMenuBG = Def.ActorFrame { CreateTemplate(),	CreateTemplate() }

LoadMenuBG[1].ExtraCommand=function(self)
	self:zoomx( self:GetZoomX() * 4 )
	self:zoomy( self:GetZoomY() * 4 )
end

LoadMenuBG[2].ExtraCommand=function(self)
	self:spin():effectmagnitude(0,0,8)
	self:zoomx( self:GetZoomX() * 1.5 )
	self:zoomy( self:GetZoomY() * 1.5 )
end

return BGA_G.Frame() .. {
	OnCommand=BGA_G.ConvertToGamePlay,
	BGA_G.SW.BG(),	LoadMenuBG
}