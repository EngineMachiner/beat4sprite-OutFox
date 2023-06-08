
local SoundWaves = beat4sprite.SoundWaves
local Path = SoundWaves.Path .. "Graphics/"

local Preferences = SoundWaves.getPreferences()

local SubTheme, Colors = Preferences.SubTheme, Preferences.Colors
local color1 = Colors(SubTheme).titleBGPattern

local Path = Path .. "_bg big grid.png"
local parameter = beat4sprite.createInternals { File = Path }

return beat4sprite.ActorFrame() .. {

	SoundWaves.quad(),	
	
	beat4sprite.ActorFrame() .. { beat4sprite.Actor(parameter) .. {

		OnCommand=function(self)

			self:init():Center()

			self:GetParent():blend('add'):diffuse(color1):diffusealpha(0.25)

			self:zoomto( SCREEN_WIDTH * 1.4, SCREEN_HEIGHT * 1.4 )
			self:customtexturerect( 0, 0, SCREEN_WIDTH * 4 / 512, SCREEN_HEIGHT * 4 / 512 )
			
			self:diffuseshift():effectperiod(4):effectcolor1( color("1,1,1,0.5") )

			self:texcoordvelocity( 0.125, 0.125 )

		end

	} }

}