
local SoundWaves = {}           beat4sprite.Modules.SoundWaves = SoundWaves

local path = "/Appearance/Themes/default/"           SoundWaves.Path = path

local function graphic(s) return SoundWaves.Path .. "Graphics/" .. s end

local function preferences()

    local Theme = LoadModule("Config.Load.lua")( "SoundwavesSubTheme", "Save/OutFoxPrefs.ini" )

    local Colors = loadfile( path .. "Modules/Theme.Colors.lua" )( Theme )

    return { Theme = Theme,       Colors = Colors(Theme) }

end

local function Quad()

    local preferences = preferences()

    local Theme, Colors = preferences.Theme, preferences.Colors

    Colors = { Colors.titleBGA,     Colors.titleBGB }

	return beat4sprite.ScreenQuad( Colors[1] ) .. {

		OnCommand=function(self) self:diffuse(Colors[1]):diffusebottomedge( Colors[2] ) end

	}

end


local t = { preferences = preferences,      Quad = Quad,        graphic = graphic }

Astro.Table.merge( SoundWaves, t )