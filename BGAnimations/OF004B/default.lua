
local Vector = Astro.Vector             local Commands = beat4sprite.Actor.Commands

local SoundWaves = beat4sprite.Modules.SoundWaves           local preferences = SoundWaves.preferences()

local Colors = preferences.Colors               Colors = { Colors.titleBGPattern,   Colors.titleBGA }


local Background = beat4sprite.Builder.SongBackground():Load()

local Builder = beat4sprite.Builder {

	Texture = "OutFox/SoundWaves/A 6x10.png",         Zoom = 2.85,

	States = { First = 1, Last = 60 },              Layers = { Back = Background },
    
    Sprite = {

        OnCommand=function(self) self:queuecommand("SpinXY") end,

        SpinXYCommand=function(self) Commands.SpinXY(self) self:queuecommand("SpinXY") end

    },

    Output = {
        
        OnCommand=function(self)
            
            self:diffusebottomedge( Colors[1] ):diffusetopedge( Colors[2] )
        
        end
    
    }

}

return Builder:merge(...):Load()