return beat4sprite.ActorFrame() .. {

    loadfile( beat4sprite.Paths.getBGAFile("OF006D") ) { 
        File = "_bg big grid.png",        TextureZoom = 0.5,
        Alpha = 0.625
    },

    loadfile( beat4sprite.Paths.getBGAFile("OF006D") ) { 
        File = "_bg inner ring.png",      TextureZoom = 1
    }[2]

}