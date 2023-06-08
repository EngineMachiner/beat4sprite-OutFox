
local SoundWaves = beat4sprite.SoundWaves
local Path = SoundWaves.Path .. "Graphics/"

local RingPath1 = Path .. "_bg inner ring.png"
local RingPath2 = Path .. "_bg outer ring.png"

local Preferences = SoundWaves.getPreferences()

local SubTheme, Colors = Preferences.SubTheme, Preferences.Colors
local color1 = Colors(SubTheme).titleBGPattern

local param1 = beat4sprite.createInternals { File = RingPath1 }
local param2 = beat4sprite.createInternals { File = RingPath2 }

-- 720 is SoundWaves screen Height
local scale = SCREEN_HEIGHT / 720

local function ring(parameters)
	
	return beat4sprite.Actor(parameters) .. {

		OnCommand=function(self)
			self:diffuse(color1)
			self:diffusealpha(0.125):blend('add')
			self:init():queuecommand("Sequence") 
		end

	}

end

local ringSet = Def.ActorFrame {

	OnCommand=function(self) self:Center() end,

	beat4sprite.ActorFrame() .. { ring(param1) .. {

		OnCommand=function(self)
			self:zoom( self:GetZoom() * 0.75 )
			self:GetParent():spin():effectmagnitude(0,0,-6)
		end,

		SequenceCommand=function(self)
			local d = self:getTweenRate() * 8
			self:rotationx(0):linear(d):rotationx(360)
			self:queuecommand("Sequence")
		end

	} },

	beat4sprite.ActorFrame() .. { ring(param2) .. {

		OnCommand=function(self)
			self:zoom( self:GetZoom() * 0.75 )
			self:GetParent():spin():effectmagnitude(0,0,4)
		end,

		SequenceCommand=function(self)
			local d = self:getTweenRate() * 8
			self:rotationy(0):linear(d):rotationy(360)
			self:queuecommand("Sequence")
		end

	} }

}

for i=1,3 do

	ringSet[#ringSet+1] = beat4sprite.ActorFrame() .. { ring(param1) .. {

		OnCommand=function(self)

			local zoom = self:GetZoom() * 0.125 * i * 0.5
			self.Zoom = zoom
			
			self:zoom(zoom):sleep( ( i - 1 ) * 0.5 )

			local r = i % 2 == 0 and -1 or 1	r = r * 25
			self:GetParent():spin():effectmagnitude(0,0,r)

		end,

		SequenceCommand=function(self)
			local d = self:getDelay() * 2
			self:smooth(d):zoom( self.Zoom * 1.75 ):diffusealpha(1)
			self:smooth(d):zoom( self.Zoom ):diffusealpha(0.5)
			self:queuecommand("Sequence")
		end

	} }

end

return beat4sprite.ActorFrame() .. { 

	InitCommand=function(self) self:fov(80) end,

	SoundWaves.quad(),		ringSet 
	
}