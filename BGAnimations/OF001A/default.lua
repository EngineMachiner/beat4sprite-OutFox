
local SoundWaves = beat4sprite.Modules.SoundWaves           local preferences = SoundWaves.preferences()

local Color = preferences.Colors.titleBGPattern             local graphic = SoundWaves.graphic


local builder = beat4sprite.Builder {}          local Zoom = builder:zoom()

local function Ring( texture )

    return beat4sprite.Sprite {
        
        Texture = texture,      OnCommand=function(self) self:init(builder):zoom(Zoom) end

    }

end

local function innerRing()

    local texture = graphic("_bg inner ring.png")          return Ring(texture)

end

local function outerRing()

    local texture = graphic("_bg outer ring.png")          return Ring(texture)

end


local BigRing = Def.ActorFrame {

	Def.ActorFrameTexture {

		OnCommand=function(self)
			
			self:setsize( SCREEN_WIDTH, SCREEN_HEIGHT ):EnableAlphaBuffer(true):Create()
			
			self:GetParent().Texture = self:GetTexture()
			
		end,

		innerRing() .. {

			OnCommand=function(self)

                local zoom = self:GetZoom() * 3.25
                
                self:zoom(zoom):xy( SCREEN_RIGHT, SCREEN_TOP )

                local Magnitude = self.Effect.Magnitude         Magnitude.z = -2
                
                self:setEffect("spin")
				
			end

		}

	},

	Def.Sprite {

		OnCommand=function(self)

			local Texture = self:GetParent().Texture        self:SetTexture(Texture)

			self:blend('add'):diffusealpha(0.25):SetTextureFiltering(false)

		end

	}

}

local function CycleCommand(self)

    local z = { 0, - 750 }          local rotation = { self:GetRotationZ() }

    local angle = 45        angle = angle * math.random( 750, 1250 ) * 0.001
    
    if math.random(2) == 2 then angle = - angle end

    rotation[2] = rotation[1] + angle


    local t = self:tweenRate() * 4              self:stoptweening()

    self:linear(t):z( z[2] ):rotationz( rotation[2] )
    self:linear(t):z( z[1] ):rotationz( rotation[1] )

    self:queuecommand("Cycle")

end

local Rings = beat4sprite.ActorFrame {

	OnCommand=function(self)

        self:init(builder):zoom(0.75)
        
        self:blend('add'):diffuse(Color):diffusealpha(0.5)        self:queuecommand("Cycle")

	end,

	innerRing(),        outerRing()

}

for i,v in ipairs(Rings) do

    local Ring = v

    Rings[i] = beat4sprite.ActorFrame {
        
        OnCommand=function(self) self:init(builder) end,
        
        Ring,   CycleCommand = CycleCommand
    
    }

end


return beat4sprite.ActorFrame {

	SoundWaves.Quad(),      Rings,        BigRing,

    OnCommand=function(self) self:Center():setScaledFOV(80) end,

}