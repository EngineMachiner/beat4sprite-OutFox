
local Path = beat4sprite.filePath("OF006A")

local SoundWaves = beat4sprite.Modules.SoundWaves           local graphic = SoundWaves.graphic

return loadfile( Path ) {

    Texture = { graphic("_bg small grid.png") },
    
    ScreenScale = false,        Mirror = true,          Scroll = false,         Zoom = 5,

    Composition = { OnCommand=function(self) self.Effect.Magnitude.z = 45 / 3          self:setEffect("spin"):zoom(1.41) end }
    
}