
local Vector = Astro.Vector

local SoundWaves = beat4sprite.Modules.SoundWaves           local preferences = SoundWaves.preferences()

local BGColor = preferences.Colors.titleBGPattern           local graphic = SoundWaves.graphic


local Builder = beat4sprite.Builder {

    Blend = 'add',  	    Scroll = Vector("Left"),            Rate = 4,

    Texture = graphic("_bg big grid.png"),         Colors = { BGColor, color("#808080") },
    
    Sprite = { OnCommand=function(self) self:setEffect("diffuseshift") end },

    Output = { LoadSpriteCommand=function(self) self:zoom( self:GetZoom() * 3 ) end }

}

return Builder:Load() .. {

    SoundWaves.Quad() .. { OnCommand=function(self) self:Center():zoom(2) end },

    OnCommand=function(self) self:init(Builder):fov(80):queuecommand("Cycle") end,

    CycleCommand=function(self)
    
        local t = self:tweenRate() * 0.5          local r = Vector( 20, 30 )

        self:linear(t):setRotation(r):linear(t):rotationx(0)

        self:linear(t):rotationy(0):linear(t):rotationy(20)

        self:queuecommand("Cycle")
    
    end

}