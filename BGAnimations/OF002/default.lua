
local prefs = BGA_G.SW.GetPrefs()
local subTheme = prefs.subTheme
local ColorTable = prefs.Colors

local default = "corner (res 512x512)"
local addPath = ... or default

local GraphP = BGA_G.GetThemesPath() .. "default/Graphics/"
local path

local LoadMenuBG = Def.ActorFrame {

	Def.Sprite {

		OnCommand=function(self)

			self:GetParent():Center()

			path = GraphP .. "_bg tri grid.png"

			BGA_G.ObjFuncs(self)
			self:Load(path)
			self:set_use_effect_clock_for_texcoords(true)
			self:diffuse( ColorTable.titleBGPattern ):diffusealpha(0.03)
			self:zoomto(SCREEN_WIDTH,SCREEN_HEIGHT)
			self:customtexturerect(0,0,SCREEN_WIDTH*4/512,SCREEN_HEIGHT*4/512)
			
			local d = self:GetDelay() * 0.075
			local coord = { 0, d }
			if addPath ~= default then coord = { d, 0 } end
			self:texcoordvelocity(coord[1], coord[2])
			
		end

	}

}


for i=1,8 do

	for j=1,3 do

		LoadMenuBG[#LoadMenuBG+1] = Def.Sprite {

			OnCommand=function(self)

				BGA_G.ObjFuncs(self)

				path = GraphP .. "_bg tri " .. addPath .. ".png"
				self:Load(path)

				local s = SCREEN_HEIGHT / 720
				self:zoom( 0.5 * s )

				local w = self:GetZoomedWidth()
				local h = self:GetZoomedHeight()
				
				local x = self:GetX() + w * ( i - 2.5 )
				if i > 4 then
					x = self:GetX() + w * ( i - 2.5 - 4 )
					self:rotationz(180)
				end
				self:x(x)
				
				self:y( self:GetY() + h * ( j - 2 ) )
				if j % 2 == 0 then 
					self:rotationx( 180 )
				end

				self:diffuse( ColorTable.titleBGPattern )
				self:diffusealpha(0):blend("add")

				local sleep = i * 2 + j - 3
				if i > 4 then sleep = i * 2 + j - 3 - 8 end
				self:sleep(sleep)

				self:queuecommand("Sequence")

			end,

			SequenceCommand=function(self)
			
				local d = self:GetDelay() * 2
				local alpha = 0.75

				if addPath ~= default then alpha = 0.25 end

				self:stoptweening()
				self:linear(d):diffusealpha(0):sleep(d)
				self:linear(d):diffusealpha(alpha)

				self:queuecommand("Sequence")

			end
			
		}

	end

end

return BGA_G.Frame() .. {
	OnCommand=BGA_G.ConvertToGamePlay,
	BGA_G.SW.BG(),
	LoadMenuBG
}
