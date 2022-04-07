

local params = BGA_G.Create( {
	File = "OutFox/A 6x10.png",
	X_num = { -4, 5 },	Y_num = 4,
	Delay = 4,	Frame_l = 60,
	Zoom = 2
} )

return BGA_G.Frame() .. {
	OnCommand=function(self)
		self:GetChildren()[""][2]:blend('add')
	end,
	params:Load(),	BGA_G.SW.BG()
}