

local SoundWaves = beat4sprite.SoundWaves
local Path = SoundWaves.Path .. "Graphics/"

local Preferences = SoundWaves.getPreferences()

local SubTheme, Colors = Preferences.SubTheme, Preferences.Colors
local color1 = Colors(SubTheme).titleBGPattern

local Path1 = Path .. "_bg big grid.png"

local param1 = beat4sprite.createInternals { File = Path1 }

-- 720 is SoundWaves screen Height
local scale = SCREEN_HEIGHT / 720

local function template()

	return beat4sprite.Actor(param1) .. {

		OnCommand=function(self)

			self:Center():init()
			self:blend('add'):diffuse(color1)
			self:zoomto( SCREEN_WIDTH * 1.4, SCREEN_HEIGHT * 1.4 )
			self:customtexturerect( 0, 0, SCREEN_WIDTH * 4 / 512, SCREEN_HEIGHT * 4 / 512 )
			self:queuecommand("Post")

		end

	}

end

return beat4sprite.ActorFrame() .. {

	SoundWaves.quad(),			beat4sprite.ActorFrame() .. {

		beat4sprite.ActorFrame() .. { template() .. {

			PostCommand=function(self)
				self:zoomx( self:GetZoomX() * 2 ):zoomy( self:GetZoomY() * 2 )
				self:queuecommand("Cycle")
			end,
			
			CycleCommand=function(self)
				local d = self:getDelay() * 4
				self:diffusealpha(0.125):sleep(d)
				self:linear(d * 0.5):diffusealpha(0):sleep(d)
				self:linear(d * 0.5):diffusealpha(0.125)
				self:queuecommand("Cycle")
			end

		} },

		beat4sprite.ActorFrame() .. { template() .. {

			PostCommand=function(self)
				self:spin():effectmagnitude(0,0,8)
				self:zoomx( self:GetZoomX() * 1.5 ):zoomy( self:GetZoomY() * 1.5 )
				self:queuecommand("Cycle")
			end,

			CycleCommand=function(self)
				local p, d = self:GetParent(), self:getDelay() * 4
				p:diffusealpha(0):sleep(d)
				p:linear(d * 0.5):diffusealpha(0.125):sleep(d)
				p:linear(d * 0.5):diffusealpha(0):queuecommand("Cycle")
			end

		} }

	}

}