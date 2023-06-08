
local SoundWaves = beat4sprite.SoundWaves
local Path = SoundWaves.Path .. "Graphics/"

local Preferences = SoundWaves.getPreferences()

local SubTheme, Colors = Preferences.SubTheme, Preferences.Colors
local color1 = Colors(SubTheme).titleBGPattern

local Path1 = Path .. "_retro checkerboard (stretch).png"
local parameter = beat4sprite.createInternals { File = Path1 }

local Path2 = Path .. "_bg small grid.png"
local param2 = beat4sprite.createInternals { File = Path2 }

return beat4sprite.ActorFrame() .. {

	InitCommand=function(self) self:fov(80) end,

	SoundWaves.quad(),

	beat4sprite.ActorFrame() .. { beat4sprite.ActorFrame() .. { 
		
		beat4sprite.Actor(parameter) .. {

			OnCommand=function(self)

				self:GetParent():GetParent():Center()

				self:init():diffuse(color1):diffusealpha(0.5)
				
				self:zoomto( SCREEN_WIDTH * 1.4, ( SCREEN_HEIGHT + 190 ) * 1.4 )
				self:customtexturerect( 0, 0, SCREEN_WIDTH * 4 / 512, SCREEN_HEIGHT * 4 / 512 )
				self:zoom( self:GetZoom() * 0.125 )

				self:queuecommand("Spin")

			end,

			SpinCommand=function(self)

				local t = self:getDelay() * 8		local p = self:GetParent()

				self:linear(t):rotationx( self:GetRotationX() + math.random( 0, 360 ) )

				p:linear(t):rotationy( p:GetRotationY() + math.random( 0, 360 ) )

				p = p:GetParent()
				p:linear(t):rotationz( p:GetRotationZ() + math.random( 0, 360 ) )

				self:queuecommand("Spin")

			end

		}

	} },

	beat4sprite.ActorFrame() .. { beat4sprite.Actor(param2) .. {
		OnCommand=function(self) 
			self:init():Center():x( SCREEN_RIGHT )
			self:spin():effectmagnitude( 0, 0, 45 )
			self:diffuse(color1):diffusealpha(0.5) 
		end
	} },

	beat4sprite.ActorFrame() .. { beat4sprite.Actor(param2) .. {
		OnCommand=function(self) 
			self:init():Center():x( SCREEN_LEFT )
			self:spin():effectmagnitude( 0, 0, -45 )
			self:diffuse(color1):diffusealpha(0.5) 
		end
	} },

	SoundWaves.quad() .. { OnCommand=function(self) self:blend('add') end }

}