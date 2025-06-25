
local Vector = Astro.Vector             local planeAxes = Vector.planeAxes


local Commands = beat4sprite.Actor.Commands

local SoundWaves = beat4sprite.Modules.SoundWaves           local preferences = SoundWaves.preferences()

local function path(s) return SoundWaves.Path .. "Graphics/" .. s .. ".png" end

local BGColor = preferences.Colors.titleBGA


local builder = beat4sprite.Builder {

    Texture = { "OutFox/SoundWaves/A 6x10.png" },         Blend = 'add',

    Colors = { BGColor, Color.White },          Rate = 4,           Zoom = 2.85,

    Angle = 0,          Matrix = function(matrix) matrix.y = matrix.x       return matrix end

}

builder = builder:merge(...)


local Scroll = Vector("UpRight")          builder.Scroll = Scroll

local Fade = builder.Scroll:copy()           Fade.y = - Fade.y

local Angle = math.atan( Scroll.y / Scroll.x )              Angle = Angle + builder.Angle

builder.Sprite = {
    
    OnCommand=function(self)

        local matrix = self.TileParent.Matrix          local offset = self.TilePos * 1.5

        for i,v in ipairs(planeAxes) do offset[v] = offset[v] * Fade[v] / matrix[v] end

        self.Effect.Period = 8          self:setEffectOffset(offset):setEffect("diffuseshift")
    
    end

}

builder.Output = { LoadSpriteCommand=function(self) self:rotationz( Angle + 45 ) end }


return beat4sprite.ActorFrame {

	SoundWaves.Quad() .. { OnCommand=function(self) self:Center() end },
    
    builder:Load()

}