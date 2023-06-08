return beat4sprite.ActorFrame() .. {

    loadfile( beat4sprite.Paths.getBGAFile("OF006D") ) { 
        File = "_bg inner ring.png",      TextureZoom = 0.6,
        EffectMagnitude = { x = 0, y = 0, z = 20 }
    },

    loadfile( beat4sprite.Paths.getBGAFile("OF006D") ) { 
        File = "_bg inner ring.png",      TextureZoom = 1.5,
        EffectMagnitude = { x = 0, y = 45, z = 20 }
    }[2]

}