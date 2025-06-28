

local Vector = Astro.Vector

local SoundWaves = beat4sprite.Modules.SoundWaves           local preferences = SoundWaves.preferences()

local Color = preferences.Colors.titleBGPattern             local graphic = SoundWaves.graphic


local builder = beat4sprite.Builder {}          local Zoom = builder:zoom()

local function Ring( texture )

    return beat4sprite.Sprite {
        
        Texture = texture,
        
        OnCommand=function(self)
            
            self:init(builder):zoom(Zoom)


            local Effect = self.Effect             Effect.Magnitude = self.Magnitude

            self:setEffect("spin")
        
        end

    }

end

local function innerRing( Sprite ) 

    local texture = graphic("_bg inner ring.png")          return Ring(texture) .. Sprite

end

local function outerRing( Sprite )

    local texture = graphic("_bg outer ring.png")          return Ring(texture) .. Sprite

end


local scale = SCREEN_HEIGHT / 720

local function CycleCommand(self)

    local z = { 0, - 750 }          for i,v in ipairs(z) do z[i] = v * scale end
    
    
    local rotation = { self:GetRotationZ() }

    local angle = 45        angle = angle * math.random( 750, 1250 ) * 0.001
    
    if math.random(2) == 2 then angle = - angle end

    rotation[2] = rotation[1] + angle


    local t = self:tweenRate() * 4              self:stoptweening()

    self:linear(t):z( z[2] ):rotationz( rotation[2] )
    self:linear(t):z( z[1] ):rotationz( rotation[1] )

    self:queuecommand("Cycle")

end

local n = 3

local function innerRing2(i) 

    local z = 25        if i % 2 == 0 then z = -z end       local magnitude = Vector { z = z }
    
    local zoom = { i * 0.11 }         zoom[2] = zoom[1] * 1.75

    local sleep = i - 1             sleep = sleep * 1.05 / n


    return beat4sprite.ActorFrame {
        
        OnCommand=function(self)
            
            self:init(builder):zoom( zoom[1] )           self:sleep(sleep):queuecommand("Cycle")
        
        end,

        CycleCommand=function(self)

			local t = self:tweenRate()          self:smooth(t):zoom( zoom[2] ):diffusealpha(1)

			self:smooth(t):zoom( zoom[1] ):diffusealpha(0.5)            self:queuecommand("Cycle")

		end,

        innerRing { InitCommand=function(self) self.Magnitude = magnitude end }

    }

end


local Rings = beat4sprite.ActorFrame {

	OnCommand=function(self)

        self:init(builder):zoom(0.5)        self:blend('add'):diffuse(Color):diffusealpha(0.5)

	end,

	innerRing { InitCommand=function(self) self.Magnitude = Vector( 0, 32, -6 ) end },
    outerRing { InitCommand=function(self) self.Magnitude = Vector( 32, 0, 4 ) end }

}

for i = 1, n do Rings[ i + 2 ] = innerRing2(i) end


return beat4sprite.ActorFrame {

	SoundWaves.Quad(),      Rings,          OnCommand=function(self) self:Center():setScaledFOV(80) end,

} 