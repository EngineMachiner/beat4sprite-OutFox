
-- Making this animation was so hard to understand in the new system. :(

-- I think it's one of the most confusing animations I've ever written.


local Vector = Astro.Vector             local planeAxes = Vector.planeAxes

local Renderer = tapLua.Sprite.Renderer


local Commands = beat4sprite.Actor.Commands

local SoundWaves = beat4sprite.Modules.SoundWaves           local preferences = SoundWaves.preferences()

local BGColor = preferences.Colors.titleBGA


local builder = beat4sprite.Builder {

    Texture = { "OutFox/SoundWaves/A 6x10.png" },           Zoom = 1.25,        

    Colors = { BGColor, Color.White },          Rate = 3,           Scroll = Vector(),

    Matrix = function(matrix) local x = matrix.x          return Vector( x, 1 ) end

}

builder = builder:merge(...)


local Scroll = builder.Scroll           local Angle = Vector.angle( Scroll )

Scroll = Vector("Right")                builder.Scroll = Scroll

builder.Sprite = {

    OnCommand=function(self)

        local p = self.TileParent          local matrix = p.Matrix             local offset = self.TilePos

        for i,v in ipairs(planeAxes) do offset[v] = offset[v] * Scroll[v] / matrix[v] end

        self.Effect.Period = 8          self:setEffectOffset(offset):setEffect("diffuseshift")
    
    end

}

builder.Composition = { OnCommand=function(self) self:rotationz(45):zoom(1.4) end }

builder.Output = { OnCommand=function(self) self:xy(0,0) end }


local Texture = builder.Texture                 local zoom = builder.Zoom

Renderer:LoadBy( Texture[1] ):zoom(zoom)           local Height = Renderer:GetZoomedHeight()


return beat4sprite.ActorFrame {

    SoundWaves.Quad() .. { OnCommand=function(self) self:Center() end },

	tapLua.ActorFrameTexture {

        builder:Load(),

        InitCommand=function(self)

            local pos = Vector( SCREEN_WIDTH, Height )

            self:setSizeVector(pos):EnableAlphaBuffer(true):Create()

            
            self:GetChild(""):setPos( pos * 0.5 )           self:queuecommand("Tile")

        end,

        TileCommand=function(self)

            local Texture = self:GetTexture()
            
            local Builder = beat4sprite.Builder {
                
                Texture = Texture,    Blend = 'add',

                Sprite = {
                    
                    OnCommand=function(self)

                        local matrix = self.TileParent.Matrix              local x = self.TilePos.y
                        
                        x = matrix.y * 0.5 - x          x = math.ceil(x)            x = math.abs(x) * 128

                        x = Vector(x)           self:moveTextureBy(x)
                    
                    end
                
                },

                Output = { LoadSpriteCommand=function(self) self:rotationz( Angle ):zoom( self:GetZoom() * 1.8 ) end }
            
            }

            local function Tile()
                
                return Builder:Load() .. { InitCommand=function(self) self:queuecommand("On") end }
            
            end

            self:GetParent():AddChild(Tile)

        end

    }

}