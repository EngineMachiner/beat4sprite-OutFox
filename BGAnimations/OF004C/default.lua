
local tweaks = BGA_G.Create( {
	File = "OutFox/A 6x10.png",
	X_num = { -4, 5 },	Y_num = 4,
	Frame_i = 1,	SpinMag = { 0, 0, 50 },
	Zoom = 1.125,	Script = "AFTSpin.lua",		
	Commands = "",	AFT = true
} )

return loadfile( BGA_G.BPath("OF004B") )( tweaks )