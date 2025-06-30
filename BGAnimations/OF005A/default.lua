
local Sprite = ... or {}

local SoundWaves = beat4sprite.Modules.SoundWaves           local graphic = SoundWaves.graphic

local preferences = SoundWaves.preferences()                local Color = preferences.Colors.titleBGPattern


local FOV = tapLua.scaleFOV(100)

local scale = SCREEN_HEIGHT / 720           local r = 10 / scale

return beat4sprite.ActorFrame {

	SoundWaves.Quad(),          OnCommand=function(self) self:setupDepth(FOV) end,

	beat4sprite.Sprite {

        Texture = graphic("_retro checkerboard (stretch).png"),

		OnCommand=function(self)

            self:rotationx(-r)         self.rotate = self.rotationx

            
            local y = 1 / self:rate()               self:fadeHorizontally(0.4)
            
            self:texcoordvelocity( 0, y )           self:diffuse(Color):diffusealpha(0.5)


            local zoom = SCREEN_HEIGHT / 720

            local size = self:GetSize() * 0.5           local w, h = size:unpack()

			self:zoom( zoom * 8 ):customtexturerect( 0, 0, 1280 / w, 720 * 1.25 / h )

		end,

        CycleCommand=function(self)

			local t = self:rate() * 8       self:rotate(-r):linear(t):rotate(r):sleep(t)
            
			self:linear(t):rotate(-r):sleep(t)        self:queuecommand("Cycle")
			
		end

	} .. Sprite

}