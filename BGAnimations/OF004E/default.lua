
local params = BGA_G.Create( {
	File = "/OutFox/A 6x10.png",
	X_num = { -4, 5 },	Y_num = 4,
	Delay = 4,	Frame_l = 60,	Fade = true,
	HurryTweenBy = 4,
	Zoom = 2,	Color = { Color.White, color("0,0,0,0") }
} )

return Def.ActorFrame{
	BGA_G.BGSet( { File = BGA_G.SongBGPath() } ):Load(),
	params:Load()
}