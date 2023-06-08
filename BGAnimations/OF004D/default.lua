
local SoundWaves = beat4sprite.SoundWaves
local Path = SoundWaves.Path .. "Graphics/"

local Preferences = SoundWaves.getPreferences()

local SubTheme, Colors = Preferences.SubTheme, Preferences.Colors
local color1 = Colors(SubTheme).titleBGA
local color2 = Colors(SubTheme).titleBGB

return beat4sprite.ActorFrame() .. {

	beat4sprite.Sprite.colorQuad(color1) .. {
		OnCommand=function(self) self:diffusebottomedge(color2) end
	},

	beat4sprite.Load {
		File = "/OutFox/SoundWaves/A 6x10.png",
		Columns = 5,					Rows = { -3, 4 },
		AnimationRate = 4,				lastState = 60,
		Zoom = 1.67,					Commands = "StairsStates",
		Cross = { By = 1, Type = 1 }
	},

	beat4sprite.Sprite.colorQuad(color1) .. {
		OnCommand=function(self) self:diffusebottomedge(color2):blend('add') end
	}

}