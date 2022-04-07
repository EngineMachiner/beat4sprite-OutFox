

local params = BGA_G.Create( {
	File = "/OutFox/A 6x10.png",
	X_num = { -4, 5 },
	Y_num = 4,
	Delay = 4,
	Frame_l = 60,
	Zoom = 2,
	Commands = { "StairsStates", "Cross" }
} )

local a = { "Config.Load.lua", "Save/OutFoxPrefs.ini" }
local ColorTable = BGA_G.LoadThemeModule( "default", "Theme.Colors.lua" )( LoadModule( a[1] )( "SoundwavesSubTheme", a[2] ) )

return BGA_G.Frame() .. {
	Def.Quad {
		InitCommand=function(self) 
			self:Center():zoomto(SCREEN_WIDTH,SCREEN_HEIGHT) 
		end,
		OnCommand=function(self) 
			self:playcommand("Init")
			self:diffuse( ColorTable.titleBGA )
			self:diffusebottomedge( ColorTable.titleBGB ) 
		end
	},
	params:Load(),
	Def.Quad {
		InitCommand=function(self) 
			self:Center():zoomto(SCREEN_WIDTH,SCREEN_HEIGHT) 
		end,
		OnCommand=function(self) 
			self:playcommand("Init")
			self:diffuse( ColorTable.titleBGA )
			self:diffusebottomedge( ColorTable.titleBGB ) 
			self:blend('add')
		end
	}
}