
local Vector = Astro.Vector

local SoundWaves = beat4sprite.Modules.SoundWaves           local preferences = SoundWaves.preferences()

local BGColor = preferences.Colors.titleBGPattern           local Colors = { BGColor, Color.Alpha( BGColor, 0 ) }

local graphic = SoundWaves.graphic


local Sprite = {

    OnCommand=function(self)

        local offset = self.TilePos / 5         self:setEffectOffset(offset):setEffect("diffuseshift")

    end

}

local builder = beat4sprite.Builder {

    Texture = "OutFox/SoundWaves/_bg tri corner (res 512x512).png",         Scroll = Vector("Down"),

    Colors = Colors,        Sprite = Sprite,        Zoom = 0.75,        Mirror = true,          Blend = 'add',

    Rotation = Vector { z = 90 },        Effect = { Period = 2 },           Rate = 4

}

builder = builder:merge(...)


local Zoom = builder:zoom()             local scale = builder.Scale

local Scroll = builder.Scroll           builder.Scroll = nil


return beat4sprite.ActorFrame {

    beat4sprite.ActorFrame {

        SoundWaves.Quad() .. { OnCommand=function(self) self:Center() end },

        beat4sprite.Sprite {

            Texture = graphic("_bg tri grid.png"),

            OnCommand=function(self)

                self:init(builder):FullScreen()

                local Scroll = Scroll / self:tweenRate()            local size = 512 * scale

                local rect = tapLua.screenSize() * 4 / size         local x, y = rect:unpack()

                self:diffusealpha(0.03)         self:customtexturerect( 0, 0, x, y ):scrollTexture( Scroll )

            end

        }

    },

    builder:Load()

}