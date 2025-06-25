
-- This could have been done queueing the scroll command and changing its value instead of using Cycle.lua

local Vector = Astro.Vector

local SoundWaves = beat4sprite.Modules.SoundWaves           local preferences = SoundWaves.preferences()

local BGColor = preferences.Colors.titleBGPattern           local graphic = SoundWaves.graphic


local function Actor(t)

    local builder = beat4sprite.Builder {

        Texture = graphic("_bg big grid.png"),         Colors = BGColor,       Zoom = 1,       Blend = 'add',

        Output = { LoadSpriteCommand=function(self) self:zoom( self:GetZoom() * 2 ):setEffect("spin") end }

    }

    return builder:merge(t):Load() .. {

        OnCommand=function(self) self:init(builder):diffusealpha(0):queuecommand("Cycle") end,

        CycleSetupCommand=function(self) self:playcommand("Animation") end,

        AnimationCommand=function(self) self:linear(1):diffusealpha(0.75):sleep(6):linear(1):diffusealpha(0) end,

        CycleCommand=function(self)

            local s = self.CycleTimes

            self:sleep( s[1] ):playcommand("Animation"):sleep( s[2] ):queuecommand("Cycle")

        end
        
    }

end

local Actor1 = Actor { Effect = { Magnitude = Vector { z = -8 } } }
local Actor2 = Actor { Effect = { Magnitude = Vector { z = 8 } } }

local Quad = SoundWaves.Quad() .. { OnCommand=function(self) self:Center() end }

return beat4sprite.Builder.Load {

    Script = "Cycle",           Actors = { Actor1,     Actor2 },            Layers = { Back = Quad }

}