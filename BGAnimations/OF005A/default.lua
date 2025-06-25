
local Sprite = ... or {}

local SoundWaves = beat4sprite.Modules.SoundWaves           local graphic = SoundWaves.graphic

local preferences = SoundWaves.preferences()                local Color = preferences.Colors.titleBGPattern

return beat4sprite.ActorFrame {

	SoundWaves.Quad(),          OnCommand=function(self) self:fov(80):Center() end,

	beat4sprite.Sprite {

        Texture = graphic("_retro checkerboard (stretch).png"),

		OnCommand=function(self)

            self:rotationx(-20)         self.rotate = self.rotationx

            local y = 1 / self:rate()               self:fadeHorizontally(0.4)
            
            self:texcoordvelocity( 0, y )           self:diffuse(Color):diffusealpha(0.5)

			self:zoomto( SCREEN_WIDTH * 2, ( SCREEN_HEIGHT + 190 ) * 2 )

			self:customtexturerect( 0, 0, SCREEN_WIDTH * 5 / 512, SCREEN_HEIGHT * 5 / 512 )

		end,

        CycleCommand=function(self)

			local t = self:rate() * 8       self:rotate(-20):linear(t):rotate(20):sleep(t)
            
			self:linear(t):rotate(-20):sleep(t)        self:queuecommand("Cycle")
			
		end

	} .. Sprite

}