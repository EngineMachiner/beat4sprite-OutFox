
local Path = beat4sprite.filePath("OF006A")

local SoundWaves = beat4sprite.Modules.SoundWaves           local graphic = SoundWaves.graphic

local function actor( path, zoom, alpha )

    return loadfile( Path ) {
        
        Texture = graphic(path),       Zoom = zoom,          Alpha = alpha,

        Composition = { OnCommand=function(self) self.Effect.Magnitude.z = 45 / 3          self:setEffect("spin"):zoom(1.41) end },

        ScreenScale = false,        Mirror = true,          Scroll = false
    
    }

end


return Def.ActorFrame {

    actor( "_bg big grid.png", 2, 0.125 ),        actor( "_bg inner ring.png", 0.5, 0.125 )[2]

}