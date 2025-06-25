
local SoundWaves = beat4sprite.Modules.SoundWaves           local planeAxes = Astro.Vector.planeAxes

return beat4sprite.ActorFrame {

	SoundWaves.Quad() .. { OnCommand=function(self) self:Center() end },

	beat4sprite.Builder.Load {

        Zoom = 3,           Blend = 'add',          Colors = { Color.White, Color.Red },

		Texture = "OutFox/SoundWaves/A 6x10.png",         States = { Last = 60,    Position = true },
        
        Sprite = {

            OnCommand=function(self)

                self.Effect.Period = 8

                local matrix = self.TileParent.Matrix          local offset = self.TilePos

                for i,v in ipairs(planeAxes) do offset[v] = offset[v] * 0.5 / matrix[v] end

                self:setEffectOffset(offset):setEffect("diffuseshift")

            end

        }

	}

}