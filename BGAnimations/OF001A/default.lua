
local SoundWaves = beat4sprite.SoundWaves
local Path = SoundWaves.Path .. "Graphics/"

local RingPath1 = Path .. "_bg inner ring.png"
local RingPath2 = Path .. "_bg outer ring.png"

local Preferences = SoundWaves.getPreferences()

local SubTheme, Colors = Preferences.SubTheme, Preferences.Colors
local color1 = Colors(SubTheme).titleBGPattern

local param1 = beat4sprite.createInternals { File = RingPath1 }
local param2 = beat4sprite.createInternals { File = RingPath2 }

-- 720 is SoundWaves Theme height.
local scale = SCREEN_HEIGHT / 720

local function ring(parameters)
	return beat4sprite.Actor(parameters) .. { OnCommand=function(self) self:init() end }
end

local RingTexture = Def.ActorFrame{

	Def.ActorFrameTexture{

		InitCommand=function(self)
			
			self:setsize( SCREEN_WIDTH, SCREEN_HEIGHT )
			self:EnableAlphaBuffer(true):Create()
			
			self:GetParent().Texture = self:GetTexture()
			
		end,

		beat4sprite.ActorFrame() .. { ring(param1) .. {

			OnCommand=function(self)

				self:xy( SCREEN_RIGHT, SCREEN_TOP )
				self:spin():effectmagnitude(0,0,-4)
				self:zoom( scale * 3.25 )

				local p = self:GetParent():GetParent():GetParent()
				p:playcommand("Draw")
				
			end

		} }

	},

	Def.Sprite {

		DrawCommand=function(self)
			self:SetTexture( self:GetParent().Texture )
			self:Center():blend('add')
			self:diffusealpha(0.065)
		end

	}

}

-- To not be confused with beat4sprite.Actor init function.
local function init(ring)

	ring:diffuse(color1)
	ring:diffusealpha(0.125):blend('add')
	ring:Center():spin():zoom( ring:GetZoom() * scale * 0.75 )
	ring:queuecommand("Sequence")

end

local RingSet = Def.ActorFrame {

	InitCommand=function(self)

		self:RunCommandsOnChildren( function(child)
		
			child:addcommand( "Sequence", function()

				local z, rotationz = child:GetZ(), child:GetRotationZ()
				local angle = math.random( 1000, 3500 ) * 0.001
				if math.random( 0, 1 ) == 1 then angle = - angle end
	
				local d = child:getDelay() * 8

				child:stoptweening()
				child:linear(d):z( z - 750 ):rotationz( rotationz + 45 * angle )
				child:linear(d):z(z):rotationz( rotationz )
	
				child:queuecommand("Sequence")
	
			end )

		end )

	end,

	beat4sprite.ActorFrame() .. { ring(param1) .. { 
		OnCommand=function(self) init(self) self:effectmagnitude(0,0,-4) end 
	} },

	beat4sprite.ActorFrame() .. { ring(param2) .. { 
		OnCommand=function(self) init(self) self:effectmagnitude(0,0,6) end 
	} }

}

return beat4sprite.ActorFrame() .. {

	InitCommand=function(self) self:fov(80) end,

	SoundWaves.quad(),		RingSet,	RingTexture,

}