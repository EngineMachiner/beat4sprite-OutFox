
local Path = beat4sprite.filePath("OF006A")             local Vector = Astro.Vector

local SoundWaves = beat4sprite.Modules.SoundWaves           local graphic = SoundWaves.graphic

local function actor( zoom )

    return loadfile( Path ) {
        
        Texture = graphic("_bg inner ring.png"),       Zoom = zoom,

        ScreenScale = false,        Mirror = true,          Scroll = false,         Alpha = 0.125,

        Composition = {
            
            OnCommand=function(self)
            
                self.Effect.Magnitude = Vector( 0, 0, 45 / 3 )          self:setEffect("spin"):zoom(1.41) 
            
            end
        
        },
    
    }

end


return Def.ActorFrame { actor(0.5),        actor(0.25)[2] }