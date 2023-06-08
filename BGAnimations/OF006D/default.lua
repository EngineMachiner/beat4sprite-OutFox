
local passed = ... or {}

local SoundWaves = beat4sprite.SoundWaves
local Path = SoundWaves.Path .. "Graphics/"

local Preferences = SoundWaves.getPreferences()

local SubTheme, Colors = Preferences.SubTheme, Preferences.Colors
local color1 = Colors(SubTheme).titleBGPattern

local Path1 = Path .. ( passed.File or "_bg small grid.png" )

local magnitude = passed.EffectMagnitude or { x = 0, y = 0, z = 90 }

local alpha = passed.Alpha or 0.75

return beat4sprite.ActorFrame() .. {

    SoundWaves.quad(),

    beat4sprite.Load {
        Columns = 6,         Rows = 3,          TextureZoom = passed.TextureZoom or 0.25,
        File = Path1,        Spin = true,       Script = "Texture.lua",
        EffectMagnitude = magnitude
    } .. { OnCommand=function(self) self:diffuse(color1):diffusealpha(alpha):blend('add') end },

}