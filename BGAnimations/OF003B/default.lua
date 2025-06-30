
local Vector = Astro.Vector

local SoundWaves = beat4sprite.Modules.SoundWaves           local preferences = SoundWaves.preferences()

local BGColor = preferences.Colors.titleBGPattern           local graphic = SoundWaves.graphic


local Builder = beat4sprite.Builder {

    Blend = 'add',  	    Scroll = Vector("Left"),            Rate = 4,

    Texture = graphic("_bg big grid.png"),         Colors = { BGColor, color("#808080") },
    
    Sprite = { OnCommand=function(self) self:setEffect("diffuseshift") end },

    Output = { LoadSpriteCommand=function(self) self:zoom( self:GetZoom() * 3 ) end }

}


local FOV = tapLua.scaleFOV(80)

local scale = SCREEN_HEIGHT / 720           local r = 20 / scale

r = { Vector( r, r ),       Vector { y = r },      Vector(),         Vector { y = r } }

return Builder:Load() .. {

    SoundWaves.Quad() .. { OnCommand=function(self) self:Center():zoom(2) end },

    OnCommand=function(self) self:init(Builder):fov(FOV):queuecommand("Cycle") end,

    CycleCommand=function(self)
    
        local t = self:tweenRate() * 0.5

        for i,v in ipairs(r) do self:linear(t):setRotation(v):sleep(t) end

        self:queuecommand("Cycle")
    
    end

}