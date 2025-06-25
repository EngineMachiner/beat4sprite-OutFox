
local Path = beat4sprite.filePath("OF005A")

return loadfile(Path) {
    
    OnCommand=function(self) self.rotate = self.rotationy       self:queuecommand("Cycle") end

}