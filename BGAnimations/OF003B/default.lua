
local SoundWaves = beat4sprite.SoundWaves
local Path = SoundWaves.Path .. "Graphics/"

local Preferences = SoundWaves.getPreferences()

local SubTheme, Colors = Preferences.SubTheme, Preferences.Colors
local color1 = Colors(SubTheme).titleBGPattern

local Path1 = Path .. "_bg big grid.png"

local param1 = beat4sprite.createInternals { File = Path1 }

local function template()

	return beat4sprite.Actor(param1) .. {

		OnCommand=function(self)

			self:Center():init()

			self:blend('add'):diffuse(color1):diffusealpha(0.125)

			self:diffuseshift():effectperiod(2):effectcolor1( color("#808080") )

			self:zoomto( SCREEN_WIDTH * 2, SCREEN_HEIGHT * 2.5 )
			self:customtexturerect( 0, 0, SCREEN_WIDTH * 4 / 512, SCREEN_HEIGHT * 4 / 512 )

			self:queuecommand("Cycle")

		end
	}

end

return beat4sprite.ActorFrame() .. {

	InitCommand=function(self) self:fov(80) end,

	SoundWaves.quad(),			template() .. {

		ScrollXCommand=function(self) self:texcoordvelocity( 0.125, 0 ) end,
		ScrollYCommand=function(self) self:texcoordvelocity( 0, 0.125 ) end,

		CycleCommand=function(self)

			local d = self:getDelay() * 8

			self:queuecommand("ScrollY")

			self:linear(d):rotationx(20):rotationy(20):linear(d):rotationx(0)

			self:queuecommand("ScrollX")

			self:linear(d):rotationy(0):linear(d):rotationy(20)

			self:queuecommand("Cycle")

		end

	}

}
