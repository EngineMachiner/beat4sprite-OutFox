
local Vector = Astro.Vector

local SoundWaves = beat4sprite.Modules.SoundWaves           local graphic = SoundWaves.graphic

local preferences = SoundWaves.preferences()                local Color = preferences.Colors.titleBGPattern


local Builder = beat4sprite.Builder {

    Blend = 'add',          Color = Color,          Rate = 2,           ScreenScale = true,
    
    Texture = graphic("_bg small grid.png"),            Scroll = Vector("Up"),          Filter = false

}

return Def.ActorFrame {
 
    SoundWaves.Quad() .. { OnCommand=function(self) self:Center() end },
    
    Builder:merge(...):Load()

}