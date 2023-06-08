
local SoundWaves = beat4sprite.SoundWaves
local Path = SoundWaves.Path .. "Graphics/"

local Preferences = SoundWaves.getPreferences()

local SubTheme, Colors = Preferences.SubTheme, Preferences.Colors
local color1 = Colors(SubTheme).titleBGPattern
local color2 = Colors(SubTheme).titleBGA

local params = beat4sprite.create {
	File = "/OutFox/SoundWaves/A 6x10.png",
	Columns = { -4, 5 },	Rows = 4,				Zoom = 2,
	AnimationRate = 4,		lastState = 60,			tweenRate = 2,
	Commands = "SpinXY"
}

params:tweak(...)

return beat4sprite.ActorFrame() .. {

	beat4sprite.Sprite.bgTemplate( { File = beat4sprite.GAMESTATE.getSongBG() } ):Load(),

	Def.ActorFrameTexture{

		InitCommand=function(self)
			self:setsize( SCREEN_WIDTH, SCREEN_BOTTOM ):EnableAlphaBuffer(true):Create()
			self:GetParent().Texture = self:GetTexture()
		end,	
		
		params:Load()

	},

	Def.Sprite {

		OnCommand=function(self)

			self:Center():SetTexture( self:GetParent().Texture )
			self:diffusebottomedge(color1):diffusetopedge(color2)

		end
		
	}

}