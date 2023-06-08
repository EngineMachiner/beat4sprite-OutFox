
local SoundWaves = beat4sprite.SoundWaves
local Path = SoundWaves.Path .. "Graphics/"

local Preferences = SoundWaves.getPreferences()

local SubTheme, Colors = Preferences.SubTheme, Preferences.Colors
local color1 = Colors(SubTheme).titleBGPattern

local Path1 = Path .. "_retro checkerboard (stretch).png"
local parameter = beat4sprite.createInternals { File = Path1 }

return beat4sprite.ActorFrame() .. {

	InitCommand=function(self) self:fov(80) end,

	SoundWaves.quad(),

	beat4sprite.Actor(parameter) .. {

		OnCommand=function(self)

			self:init():Center():texcoordvelocity( 0, 0.125 )

			self:diffuse(color1):diffusealpha(0.5):fadeleft(0.4):faderight(0.4)

			self:zoomto( SCREEN_WIDTH * 1.4, ( SCREEN_HEIGHT + 190 ) * 1.4 )
			self:customtexturerect( 0, 0, SCREEN_WIDTH * 4 / 512, SCREEN_HEIGHT * 4 / 512 )

			self:queuecommand("Cycle")

		end,

		CycleCommand=function(self)

			local t = self:getDelay() * 8
			self:rotationx(-20):linear(t):rotationx(20):sleep( t * 2 )
			self:linear(t):rotationx(-20):sleep( t * 2 ):queuecommand("Cycle")
			
		end

	},

	SoundWaves.quad() .. { OnCommand=function(self) self:blend('add') end }

}