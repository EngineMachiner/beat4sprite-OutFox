
local SoundWaves = beat4sprite.SoundWaves
local Path = SoundWaves.Path .. "Graphics/"

local Preferences = SoundWaves.getPreferences()

local SubTheme, Colors = Preferences.SubTheme, Preferences.Colors
local color1 = Colors(SubTheme).titleBGA

local passed = ... or {}

local scroll = passed.Scroll or { x = 1, y = 0 }
tapLua.Vector.toUnit(scroll)

local scrollOffset = passed.ScrollOffset or 0
local angle = tapLua.Vector.getAngle(scroll) + 45

return beat4sprite.ActorFrame() .. {

	SoundWaves.quad(),

	beat4sprite.Load {

		Script = "Texture.lua",

		File = "/OutFox/SoundWaves/A 6x10.png",			lastState = 1,
		Columns = 4,	Rows = 2,
		
		Rotation = { x = 0, y = 0, z = angle },	TextureZoom = 0.7,		
		
		Fade = { x = scroll.x, y = scroll.y },				FadeAmplitude = 0.25,

		Scroll = scroll,						ScrollOffset = scrollOffset,

		EffectPeriod = 8,						Blend = 'add',			
		EffectColors = { color1, Color.White },

	}

}