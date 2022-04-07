
local prefs = BGA_G.SW.GetPrefs()
local ColorTable = prefs.Colors

local sub = ...

local params = BGA_G.Create( {
	File = "/OutFox/A 6x10.png",
	X_num = { -4, 5 },	Y_num = 4,
	Delay = 4,	Frame_l = 60,
	Zoom = 2,	Commands = "SpinXY"
} )

params:ParTweak( sub )

return BGA_G.Frame() .. {
	BGA_G.BGSet( { File = BGA_G.SongBGPath() } ):Load(),
	Def.ActorFrameTexture{
		OnCommand=function(self)
			local p = self:GetParent()
			self:setsize( SCREEN_WIDTH, SCREEN_BOTTOM )
			self:EnableAlphaBuffer(true)
			if not p.Tex then self:Create() end
			p.Tex = self:GetTexture()
		end,	params:Load()
	},
	Def.Sprite{
		OnCommand=function(self)

			BGA_G.ObjFuncs(self)
			self:SetTexture(self:GetParent().Tex):Center()
			
			BGA_G.bitEyeFix(self, function(self) 
				bitEye.AFT = true	self:xy(0,0)
			end)

			-- Gotta adjust those colors
			local color = ColorTable.titleBGA
			local sorted = {}		DeepCopy(color, sorted)
			table.sort( sorted )
			for i=1,3 do
				if color[i] ~= sorted[3] then
					color[i] = color[i] * 20
				else
					color[i] = 1
				end
			end

			self:diffusebottomedge( ColorTable.titleBGA )

		end
	}
}