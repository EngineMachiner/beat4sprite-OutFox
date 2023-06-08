
local SoundWaves = beat4sprite.SoundWaves

return beat4sprite.ActorFrame() .. {

	beat4sprite.Load {
		File = "OutFox/SoundWaves/A 6x10.png",
		Columns = { -4, 5 },	Rows = 4,
		AnimationRate = 4,	lastState = 60,
		Zoom = 2
	},

	SoundWaves.quad() .. { OnCommand=function(self) self:blend('add') end }

}