
local Vector = Astro.Vector

local SoundWaves = beat4sprite.Modules.SoundWaves           local preferences = SoundWaves.preferences()

local BGColor = preferences.Colors.titleBGPattern           local graphic = SoundWaves.graphic


local Builder = beat4sprite.Builder {

    Blend = 'add',  	    Scroll = Vector("UpRight"),            Rate = 4,        Zoom = 2,

    Texture = graphic("_bg big grid.png"),         Colors = { BGColor, color("#808080") },
    
    Sprite = { OnCommand=function(self) self:setEffect("diffuseshift") end },

}

return Builder:Load() .. {

    SoundWaves.Quad() .. { OnCommand=function(self) self:Center() end }

}