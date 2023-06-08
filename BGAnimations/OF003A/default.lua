
local SoundWaves = beat4sprite.SoundWaves
local Path = SoundWaves.Path .. "Graphics/"

local Preferences = SoundWaves.getPreferences()

local SubTheme, Colors = Preferences.SubTheme, Preferences.Colors
local color1 = Colors(SubTheme).titleBGPattern

local Path1 = Path .. "_bg big grid.png"

local param1 = beat4sprite.createInternals { File = Path1 }

local function alpha( self, alpha )

	local d = self:getDelay() * 0.5			local tween1, tween2 = d * 7, d

	self:diffusealpha( alpha[1] )
	self:sleep(tween1):linear(tween2):diffusealpha( alpha[2] )
	self:sleep(tween1):linear(tween2):diffusealpha( alpha[1] )
	self:queuecommand("AlphaCycle")

end

local function template()

	return beat4sprite.Actor(param1) .. {

		OnCommand=function(self)

			self.alpha = alpha

			self:init():Center()
			self:diffuse(color1):diffusealpha(0.125):blend('add')
			self:zoomto( SCREEN_WIDTH * 1.4, SCREEN_HEIGHT * 1.4 )
			self:customtexturerect( 0, 0, SCREEN_WIDTH * 4 / 512 , SCREEN_HEIGHT * 4 / 512 )
			self:queuecommand("Post"):queuecommand("AlphaCycle")

		end
	}

end

local t = beat4sprite.ActorFrame() .. {

	template() .. {

		PostCommand=function(self) self:texcoordvelocity( 0, 0.125 ) end,
		AlphaCycleCommand=function(self) self:alpha( { 0.125, 0 } ) end

	},

	template() .. { 
		
		PostCommand=function(self) 
			self:texcoordvelocity( 0, - 0.125 ):fadeleft(0.4):faderight(0.4)
		end,
	
		AlphaCycleCommand=function(self) self:alpha( { 0, 0.125 } ) end

	}

}

return beat4sprite.ActorFrame() .. { SoundWaves.quad(),	t }