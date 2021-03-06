local params = ...

local HT = params.HurryTweenBy or 1
local X = params.ZoomX or SCREEN_HEIGHT * 0.05
HT = HT / X

local t = Def.ActorFrame{}

-- Texture 
local params_2 = params:Copy( {
	X_pos = 0.24 * 0.75,
	Mirror = true,		X_num = 1,
	TCV = { -1, 0 },	Reversed = true,
	ZoomXYZ = { X, 1, 1 },	HurryTweenBy = HT,
	Script = "TileTool.lua",
	Commands = "Mirror",
} )

t[#t+1] = params_2:Load()

-- Mask
local t2 = t[#t]
t2[#t2+1] = Def.Quad{
	OnCommand=function(self)
		BGA_G.ObjFuncs(self)
		self:FullScreen()
		self:x( - SCREEN_WIDTH * 0.5 )
		self:clearzbuffer(true)
		self:zwrite(true)
		self:blend("BlendMode_NoEffect")
		self:queuecommand("Repeat")
	end,
	GainFocusCommand=function(self)
		self:set_tween_uses_effect_delta(false)
		self:finishtweening()
		self:queuecommand("On")
	end,
	RepeatCommand=function(self)
		local d = self:GetFullDelay(params)
		d = d * HT * X * 7.5
		self:linear( d )
		self:x( SCREEN_WIDTH * 0.5 )
		self:linear( d )
		self:x( - SCREEN_WIDTH * 0.5 )
		self:queuecommand("Repeat")
	end
}

-- Background
t[#t+1] = Def.ActorFrame{
	OnCommand=function(self) self:ztest(true) end,
	BGA_G.Load( {
		File = params.File, X_num = 1,
		Commands = "Mirror"
	} )
}

return BGA_G.Frame() .. {

	Def.ActorFrameTexture{ t,
		InitCommand=function(self)
			self:EnableDepthBuffer(true)
			self:SetSize( SCREEN_WIDTH, SCREEN_HEIGHT )
			self:Create()
			self:GetParent().Texture = self:GetTexture()
		end
	},

	Def.Sprite{
		OnCommand=function(self)
			local tex = self:GetParent().Texture
			self:SetTexture(tex):Center()
			self:SetTextureFiltering(false)
			BGA_G.bitEyeFix(self, function(self)
				bitEye.AFT = true		self:xy(0,0)
			end)
		end
	}
	
}