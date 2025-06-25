
local Vector = Astro.Vector             local planeAxes = Vector.planeAxes

local SoundWaves = beat4sprite.Modules.SoundWaves           local graphic = SoundWaves.graphic

local preferences = SoundWaves.preferences()                local Color = preferences.Colors.titleBGPattern


local function random() return math.random( 90, 360 ) end

local Path = beat4sprite.filePath("OF005A")

local checkerBoard = loadfile(Path) {

    OnCommand=function(self) self:zoom( self:GetZoom() * 0.125 ):queuecommand("Spin") end,

    SpinCommand=function(self)

        local t = self:rate() * 8           local rotation = Vector()

        for i,v in ipairs(planeAxes) do rotation[v] = random() end

        self:linear(t):setRotation(rotation):queuecommand("Spin")

    end

}


local Builder = beat4sprite.Builder { Filter = false }

local function grid(z)

    return beat4sprite.Sprite {

        Texture = graphic("_bg small grid.png"),

        OnCommand=function(self)

            local z = z * 0.5

            self:init(Builder):CenterY():fitInScreen():zoom( self:GetZoom() * 0.9 )            
            
            local Effect = self.Effect          Effect.Magnitude.z = z
            
            self:setEffect("spin")

        end

    }

end

return beat4sprite.ActorFrame {

    checkerBoard,

    beat4sprite.ActorFrame {

        OnCommand=function(self) self:diffuse(Color):diffusealpha(0.5) end,

        grid(45) .. { OnCommand=function(self) self:x( SCREEN_RIGHT ) end },

        grid(-45) .. { OnCommand=function(self) self:x( SCREEN_LEFT ) end }

    }

}