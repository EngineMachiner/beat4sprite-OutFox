

local SoundWaves = beat4sprite.Modules.SoundWaves           local preferences = SoundWaves.preferences()

local Colors = preferences.Colors               Colors = { Colors.titleBGA,     Colors.titleBGB }


return beat4sprite.ActorFrame {

	beat4sprite.ScreenQuad( Colors[1] ) .. {

		OnCommand=function(self) self:Center():diffusebottomedge( Colors[2] ) end

	},

	beat4sprite.Builder.Load {

        Zoom = 3,           Blend = 'add',

		Texture = "OutFox/SoundWaves/A 6x10.png",         States = { Last = 60,    Position = true },
        
        Visibility = function( i, j ) i = i + j         return i % 2 == 0 end

	}

}