
-- This could have been done queueing the scroll command and changing its value instead of using Cycle.lua

local Vector = Astro.Vector

local SoundWaves = beat4sprite.Modules.SoundWaves           local preferences = SoundWaves.preferences()

local BGColor = preferences.Colors.titleBGPattern           local graphic = SoundWaves.graphic


local function Actor(t)

    local builder = beat4sprite.Builder {

        Texture = graphic("_bg big grid.png"),         Colors = BGColor,       Zoom = 4,       Blend = 'add'

    }

    return builder:merge(t):Load() .. {

        OnCommand=function(self) self:init(builder):diffusealpha(0):queuecommand("Cycle") end,

        CycleSetupCommand=function(self) self:playcommand("Animation") end,

        AnimationCommand=function(self) self:linear(1):diffusealpha(1):sleep(6):linear(1):diffusealpha(0) end,

        CycleCommand=function(self)

            local s = self.CycleTimes

            self:sleep( s[1] ):playcommand("Animation"):sleep( s[2] ):queuecommand("Cycle")

        end
        
    }

end

local Actor1 = Actor { Scroll = Vector("Up") }
local Actor2 = Actor { Scroll = Vector("Down") }

local Quad = SoundWaves.Quad() .. { OnCommand=function(self) self:Center() end }

return beat4sprite.Builder.Load {

    Script = "Cycle",           Actors = { Actor1,     Actor2 },            Layers = { Back = Quad }

}