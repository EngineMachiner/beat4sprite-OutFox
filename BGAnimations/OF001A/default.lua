
local prefs = BGA_G.SW.GetPrefs()
local subTheme = prefs.subTheme
local ColorTable = prefs.Colors

-- 720 is SoundWaves screen Height
local scale = SCREEN_HEIGHT / 720

local function Action(ring)

	BGA_G.ObjFuncs(ring)

	ring:diffuse( ColorTable.titleBGPattern )

	ring:blend('add')

	if ring.NoAction then return end

	ring:spin():Center():diffusealpha(0.11)
	ring:zoom( ring:GetZoom() * scale * 0.75 )
	
	if not ring.CmdsSet then
		ring:addcommand("Sequence", function()

			local zInfo = { ring:GetZ(), ring:GetRotationZ() }
			local d = ring:GetDelay(1) * 8
			local ang = math.random( 1000, 3500 ) * 0.001
			local clockWise = math.random(0,1)
			clockWise = clockWise == 0 and -1 or 1
			ang = ang * clockWise

			ring:stoptweening()

			ring:linear(d):z( zInfo[1] - 750 )
			ring:rotationz( zInfo[2] + 45 * ang )
			ring:linear(d):z( zInfo[1] )
			ring:rotationz( zInfo[2] )

			ring:queuecommand("Sequence")

		end)
	end
	ring.CmdsSet = true

	ring:queuecommand("Sequence")

end

local GraphP = BGA_G.GetThemesPath() .. "default/Graphics/"
local path = GraphP .. "_bg inner ring.png"

local newRingAFT = Def.ActorFrameTexture{

	OnCommand=function(self)
		local p = self:GetParent()
		self:SetWidth( SCREEN_WIDTH )
		self:SetHeight( SCREEN_HEIGHT )
		self:EnableAlphaBuffer(true)
		if not p.Texture then self:Create() end
		p.Texture = self:GetTexture()
		p:playcommand("Draw")
	end,

	Def.Sprite {
		OnCommand=function(self)
			path = GraphP .. "_bg inner ring.png"
			self.NoAction = true		Action(self)
			self:SetTextureFiltering(false)
			self:Load(path):xy(SCREEN_RIGHT, SCREEN_TOP)
			self:spin():effectmagnitude(0,0,-2)
			self:zoom( scale * 3.25 )
		end
	}

}

local LoadMenuBG = Def.ActorFrame {
	LoadCommand=function(self)
		self:RunCommandsOnChildren( 
			function(child) Action(child) end 
		)
	end,
	Def.Sprite {
		OnCommand=function(self)
			self:Load(path):effectmagnitude(0,0,-2)
			self:GetParent():queuecommand("Load")
		end	
	},
	Def.Sprite {
		OnCommand=function(self)
			path = GraphP .. "_bg outer ring.png"
			self:Load(path):effectmagnitude(0,0,3)
		end
	}
}

return BGA_G.Frame() .. {
	InitCommand=function(self) 
		self:fov(80)	BGA_G.bitEyeFix(self)
	end,
	OnCommand=BGA_G.ConvertToGamePlay,
	BGA_G.SW.BG(),		LoadMenuBG,		newRingAFT,
	Def.Sprite{
		DrawCommand=function(self)
			self:SetTexture(self:GetParent().Texture)
			self:Center():blend('add')
			self:diffusealpha(0.05)
		end 
	}
}