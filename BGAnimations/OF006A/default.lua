
local SoundWaves = beat4sprite.SoundWaves
local Path = SoundWaves.Path .. "Graphics/"

local Preferences = SoundWaves.getPreferences()

local SubTheme, Colors = Preferences.SubTheme, Preferences.Colors
local color1 = Colors(SubTheme).titleBGPattern

local Path1 = Path .. "_bg hex2 grid.png"
local param1 = beat4sprite.createInternals { 
	File = Path1, Blend = 'add', Columns = 3, Rows = 2, Zoom = 0.3
}

local Path2 = Path .. "_bg small grid.png"
local param2 = beat4sprite.createInternals { File = Path2 }

local passed = ... or {}
local Scroll = passed.Scroll or { x = 0, y = 0.125 }

return beat4sprite.ActorFrame() .. {

	SoundWaves.quad(),

	param1:Load() .. {
		OnCommand=function(self)
			self:diffusealpha(0.0625):diffuseshift():effectperiod(4)
		end
	},

	beat4sprite.Actor(param2) .. {

		OnCommand=function(self)

			self:init():Center():texcoordvelocity( Scroll.x, Scroll.y )

			if passed.FullScreen then self:FullScreen() end

			self:blend('add'):diffusealpha(0.5)

		end

	},

}