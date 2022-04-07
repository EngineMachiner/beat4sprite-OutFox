
local prefs = BGA_G.SW.GetPrefs()
local subTheme = prefs.subTheme
local ColorTable = prefs.Colors

-- 720 is SoundWaves screen Height
local scale = SCREEN_HEIGHT / 720

local function Action(ring)

	ring.Sequencer = Sequencer
	ring.p = ring:GetParent()

	BGA_G.ObjFuncs(ring)    BGA_G.ObjFuncs(ring.p)

	ring.p:diffusealpha(0.11)
	ring:zoom( ring:GetZoom() * scale )
	ring:diffuse( ColorTable.titleBGPattern )

	ring:blend('add')
	ring:queuecommand("Sequence")

end

local GraphP = BGA_G.GetThemesPath() .. "default/Graphics/"
local path = GraphP .. "_bg inner ring.png"

local LoadMenuBG = Def.ActorFrame {
	Def.ActorFrame { Def.Sprite {
		OnCommand=function(self)
			self:Load(path) 	Action(self)
			self:zoom( self:GetZoom() * 0.6 )
            self.p:GetParent():Center()
			self.p:spin():effectmagnitude(0,0,-3)
		end,
		SequenceCommand=function(self)
			local d = self:GetDelay() * 8
			self:rotationx(0):linear(d):rotationx(360)
			self:queuecommand("Sequence")
		end
	} },
	Def.ActorFrame { Def.Sprite {
		OnCommand=function(self)
			path = GraphP .. "_bg outer ring.png"
			self:Load(path)		Action(self)
			self:zoom( self:GetZoom() * 0.6 )
			self.p:spin():effectmagnitude(0,0,2)
		end,
		SequenceCommand=function(self)
			local d = self:GetDelay() * 8
			self:rotationy(0):linear(d):rotationy(360)
			self:queuecommand("Sequence")
		end
	} }
}

for i=1,3 do
	LoadMenuBG[#LoadMenuBG+1] = Def.ActorFrame{
		Def.Sprite {	
			OnCommand=function(self)
				path = GraphP .. "_bg inner ring.png"
				self:Load(path)		Action(self)

				self.z = self:GetZoom() * 0.125
				self.z = self.z  * i * 0.5
				self:zoom( self.z )
				self:sleep( ( i - 1 ) * 0.5 )

				local r = i % 2 == 0 and -1 or 1	r = r * 25
				self.p:spin():effectmagnitude(0,0,r)
			end,
			SequenceCommand=function(self)
				local d = self:GetDelay() * 2
				self:smooth(d):zoom( self.z * 1.75 ):diffusealpha(1)
				self:smooth(d):zoom( self.z ):diffusealpha(0.5)
				self:queuecommand("Sequence")
			end
		}
	}
end

return BGA_G.Frame() .. {
	InitCommand=function(self) 
		self:fov(80)	BGA_G.bitEyeFix(self)
	end,
	OnCommand=BGA_G.ConvertToGamePlay,
	BGA_G.SW.BG(),		LoadMenuBG
}