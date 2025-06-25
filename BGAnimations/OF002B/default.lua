
local Path = beat4sprite.filePath("OF002")              local Vector = Astro.Vector

local SoundWaves = beat4sprite.Modules.SoundWaves           local graphic = SoundWaves.graphic

return loadfile( Path ) {

    Texture = graphic("_bg tri grid.png"),          Scroll = Vector("Right"),           Alpha = 0.125

}