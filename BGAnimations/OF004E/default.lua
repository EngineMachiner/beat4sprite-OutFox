
local SoundWaves = beat4sprite.SoundWaves

local params = beat4sprite.create {
	File = "/OutFox/SoundWaves/A 6x10.png",		Columns = { -4, 5 },		Rows = 4,
	AnimationRate = 4,					lastState = 60,				Fade = { x = 1, y = 1 },
	Zoom = 2,							EffectColors = { Color.White, Color.Red },
	EffectPeriod = 0.25,				Blend = 'add'
}

return beat4sprite.ActorFrame() .. { SoundWaves.quad(),		params:Load() }