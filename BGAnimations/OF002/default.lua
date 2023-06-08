
local SoundWaves = beat4sprite.SoundWaves
local Path = SoundWaves.Path .. "Graphics/"

local Preferences = SoundWaves.getPreferences()

local SubTheme, Colors = Preferences.SubTheme, Preferences.Colors
local color1 = Colors(SubTheme).titleBGPattern

local passedArguments = ... or {}

local Scroll = passedArguments.Scroll or { x = 0, y = 0.125 }

local Path1 = Path .. "_bg tri grid.png"
local Path2 = Path .. "_bg tri " .. ( passedArguments.Path2 or "corner (res 512x512)" ) .. ".png"

local param1 = beat4sprite.createInternals { File = Path1 }
local param2 = beat4sprite.createInternals { File = Path2 }

local t = beat4sprite.ActorFrame() .. { 
	
	beat4sprite.ActorFrame() .. { beat4sprite.Actor(param1) .. {

		OnCommand=function(self)

			self:init():FullScreen()

			self:diffuse(color1):diffusealpha(0.03)
			self:customtexturerect( 0, 0, SCREEN_WIDTH * 4 / 512, SCREEN_HEIGHT * 4 / 512 )
			self:texcoordvelocity( Scroll.x, Scroll.y )
			
		end

	} }

}


for i=1,8 do

	for j=1,3 do

		t[#t+1] = beat4sprite.ActorFrame() .. { beat4sprite.Actor(param2) .. {

			OnCommand=function(self)

				self:GetParent():Center()
				self:init():zoom( SCREEN_CENTER_Y / 720 )

				local w, h = self:GetZoomedWidth(), self:GetZoomedHeight()
				
				local x = w * ( i - 2.5 )

				if i > 4 then x = w * ( i - 6.5 )	self:rotationz(180) end

				if j % 2 == 0 then self:rotationx(180) end

				self:xy( x, h * ( j - 2 ) )
				self:diffuse(color1):diffusealpha(0):blend("add")

				local sleep = i * 2 + j - 3		if i > 4 then sleep = sleep - 8 end
				self:sleep(sleep)

				self:queuecommand("Sequence")

			end,

			SequenceCommand=function(self)
			
				local d = self:getDelay() * 2

				local alpha = passedArguments.Alpha or 0.75

				self:stoptweening()
				self:linear(d):diffusealpha(0):sleep(d)
				self:linear(d):diffusealpha(alpha)

				self:queuecommand("Sequence")

			end
			
		} }

	end

end

return beat4sprite.ActorFrame() .. { SoundWaves.quad(),	t }
